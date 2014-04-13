require 'bundler/setup'
require 'sqlite3'
require 'sequel'
require 'csv'
require 'redis'
require 'json'

REDIS = Redis.new
SCHEMA = YAML.load_file('contrib/schema.yml')
STATES = Dir["eDNE_Basico_1304/Delimitado/LOG_LOGRADOURO_*"]
DB = Sequel.connect('sqlite://contrib/correios.sqlite3')

class Correios < Thor
  desc :load, 'Load schema.sql file into the database'
  def load
    DB.run File.read('contrib/schema.sql')
  end

  desc :prepare, 'Fix illegal quoting (run this before seeding)'
  def prepare
    `env LANG=c sed -E -n -i '' -e 's#[|]##g' eDNE_Basico_1304/Delimitado/*.TXT`
  end

  desc :seed, 'Seed postal code data into MySQL database'
  def seed
    SCHEMA.keys.each { |k| capture k }
  end

  desc :cache, 'Mirror postal codes to Redis in-memory'
  def cache
    cache_rows <<-SQL
      SELECT log_logradouro.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            log_bairro.bai_no AS bai_no,
            log_logradouro.tlo_tx || " " || log_logradouro.log_no AS log_no,
            log_logradouro.cep AS cep,
            log_logradouro.log_complemento AS log_complemento,
            "" AS nome
      FROM log_logradouro,
          log_localidade,
          log_bairro
      WHERE log_logradouro.loc_nu = log_localidade.loc_nu
        AND log_logradouro.bai_nu_ini = log_bairro.bai_nu
        AND log_logradouro.log_sta_tlo = "S"
    SQL

    cache_rows <<-SQL
      SELECT log_logradouro.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            log_bairro.bai_no AS bai_no,
            log_logradouro.log_no AS log_no,
            log_logradouro.cep AS cep,
            log_logradouro.log_complemento AS log_complemento,
            "" AS nome
      FROM log_logradouro,
          log_localidade,
          log_bairro
      WHERE log_logradouro.loc_nu = log_localidade.loc_nu
        AND log_logradouro.bai_nu_ini = log_bairro.bai_nu
        AND log_logradouro.log_sta_tlo = "N"
    SQL

    cache_rows <<-SQL
      SELECT log_localidade.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            "" AS bai_no,
            "" AS log_no,
            log_localidade.cep AS cep,
            "" AS log_complemento,
            "" AS nome
      FROM log_localidade
      WHERE log_localidade.cep IS NOT NULL
    SQL

    cache_rows <<-SQL
      SELECT log_cpc.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            "" AS bai_no,
            log_cpc.cpc_endereco AS log_no,
            log_cpc.cep AS cep,
            "" AS log_complemento,
            cpc_no AS nome
      FROM log_cpc,
          log_localidade
      WHERE log_cpc.loc_nu = log_localidade.loc_nu
    SQL

    cache_rows <<-SQL
      SELECT log_grande_usuario.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            log_bairro.bai_no AS bai_no,
            log_grande_usuario.gru_endereco AS log_no,
            log_grande_usuario.cep AS cep,
            "" AS log_complemento,
            gru_no AS nome
      FROM log_grande_usuario,
          log_localidade,
          log_bairro
      WHERE log_grande_usuario.loc_nu = log_localidade.loc_nu
        AND log_grande_usuario.bai_nu = log_bairro.bai_nu
    SQL

    cache_rows <<-SQL
      SELECT log_unid_oper.ufe_sg AS ufe_sg,
            log_localidade.loc_no AS loc_no,
            log_bairro.bai_no AS bai_no,
            log_unid_oper.uop_endereco AS log_no,
            log_unid_oper.cep AS cep,
            "" AS log_complemento,
            uop_no AS nome
      FROM log_unid_oper,
          log_localidade,
          log_bairro
      WHERE log_unid_oper.loc_nu = log_localidade.loc_nu
        AND log_unid_oper.bai_nu = log_bairro.bai_nu
    SQL
  end

  private

  def each_row(table_name, &block)
    path = "eDNE_Basico_1304/Delimitado/#{table_name}.txt"
    CSV.foreach File.expand_path(path), col_sep: "@", encoding:
      "iso-8859-1:utf-8", quote_char: "|", &block
  end

  def capture(table_name)
    keys = SCHEMA[table_name.to_s]
    items = DB[table_name.to_sym]
    items.delete
    return unless items.count.zero?
    populate = Proc.new do |n|
      each_row n do |row|
        item = keys.zip(row).inject({}) { |h, kv| h.store(*kv); h }
        items.insert(item)
      end
    end

    if table_name.include? 'log_logradouro'
      STATES.each { |n| populate.call File.basename(n).gsub(/\.txt/i, '') }
    else
      populate.call table_name
    end
  end

  def cache_rows(query)
    DB[query].each do |row|
      address = Hash.new
      address[:cep] = row[:cep]
      address[:state] = row[:ufe_sg]
      address[:city] = row[:loc_no]
      address[:neighborhood] = row[:bai_no]
      address[:street] = row[:log_no]
      address[:extras] = (row[:nome].to_s + " " + row[:log_complemento].to_s).strip
      REDIS.set(row[:cep], address.to_json)
    end
  end
end
