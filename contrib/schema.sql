DROP TABLE IF EXISTS `log_bairro`;
DROP TABLE IF EXISTS `log_cpc`;
DROP TABLE IF EXISTS `log_faixa_bairro`;
DROP TABLE IF EXISTS `log_faixa_cpc`;
DROP TABLE IF EXISTS `log_faixa_localidade`;
DROP TABLE IF EXISTS `log_faixa_uf`;
DROP TABLE IF EXISTS `log_faixa_uop`;
DROP TABLE IF EXISTS `log_grande_usuario`;
DROP TABLE IF EXISTS `log_localidade`;
DROP TABLE IF EXISTS `log_logradouro`;
DROP TABLE IF EXISTS `log_num_sec`;
DROP TABLE IF EXISTS `log_unid_oper`;
DROP TABLE IF EXISTS `log_var_bai`;
DROP TABLE IF EXISTS `log_var_loc`;
DROP TABLE IF EXISTS `log_var_log`;

CREATE TABLE `log_bairro` (
  `bai_nu` int(8) NOT NULL,
  `ufe_sg` varchar(2) NOT NULL DEFAULT '',
  `loc_nu` varchar(8) NOT NULL DEFAULT '',
  `bai_no` varchar(72) NOT NULL DEFAULT '',
  `bai_no_abrev` varchar(36) DEFAULT '',
  PRIMARY KEY (`bai_nu`)
);

CREATE TABLE `log_cpc` (
  `cpc_nu` int(8) NOT NULL,
  `ufe_sg` varchar(2) NOT NULL DEFAULT '',
  `loc_nu` int(8) NOT NULL,
  `cpc_no` varchar(72) NOT NULL DEFAULT '',
  `cpc_endereco` varchar(100) NOT NULL DEFAULT '',
  `cep` varchar(8) NOT NULL DEFAULT ''
);

CREATE TABLE `log_faixa_bairro` (
  `bai_nu` int(8) NOT NULL,
  `fcb_cep_ini` varchar(8) NOT NULL DEFAULT '',
  `fcb_cep_fim` varchar(8) NOT NULL DEFAULT ''
);

CREATE TABLE `log_faixa_cpc` (
  `cpc_nu` int(8) NOT NULL,
  `cpc_inicial` varchar(6) NOT NULL DEFAULT '',
  `cpc_final` varchar(6) NOT NULL DEFAULT ''
);

CREATE TABLE `log_faixa_localidade` (
  `loc_nu` int(8) NOT NULL,
  `loc_cep_ini` varchar(8) NOT NULL DEFAULT '',
  `loc_cep_fim` varchar(8) NOT NULL DEFAULT ''
);

CREATE TABLE `log_faixa_uf` (
  `ufe_sg` char(2) NOT NULL DEFAULT '',
  `ufe_cep_ini` char(8) NOT NULL DEFAULT '',
  `ufe_cep_fim` char(8) NOT NULL DEFAULT ''
);

CREATE TABLE `log_faixa_uop` (
  `uop_nu` int(8) NOT NULL,
  `fnc_inicial` int(8) NOT NULL,
  `fnc_final` int(8) NOT NULL
);

CREATE TABLE `log_grande_usuario` (
  `gru_nu` int(8) NOT NULL,
  `ufe_sg` varchar(2) NOT NULL DEFAULT '',
  `loc_nu` int(8) NOT NULL,
  `bai_nu` int(8) NOT NULL,
  `log_nu` int(8) DEFAULT NULL,
  `gru_no` varchar(72) NOT NULL DEFAULT '',
  `gru_endereco` varchar(100) NOT NULL DEFAULT '',
  `cep` varchar(8) NOT NULL DEFAULT '',
  `gru_no_abrev` varchar(36) DEFAULT ''
);

CREATE TABLE `log_localidade` (
  `loc_nu` int(8) NOT NULL,
  `ufe_sg` char(2) NOT NULL DEFAULT '',
  `loc_no` varchar(72) NOT NULL DEFAULT '',
  `cep` varchar(8) DEFAULT NULL,
  `loc_in_sit` char(1) NOT NULL DEFAULT '',
  `loc_in_tipo_loc` char(1) NOT NULL DEFAULT '',
  `loc_nu_sub` int(8) DEFAULT NULL,
  `loc_no_abrev` varchar(36) DEFAULT NULL,
  `mun_nu` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`loc_nu`)
);

CREATE TABLE `log_logradouro` (
  `log_nu` int(8) NOT NULL,
  `ufe_sg` varchar(2) NOT NULL DEFAULT '',
  `loc_nu` int(8) NOT NULL,
  `bai_nu_ini` int(8) NOT NULL,
  `bai_nu_fim` int(8) DEFAULT NULL,
  `log_no` varchar(100) NOT NULL DEFAULT '',
  `log_complemento` varchar(100) DEFAULT NULL,
  `cep` varchar(8) NOT NULL DEFAULT '',
  `tlo_tx` varchar(36) NOT NULL DEFAULT '',
  `log_sta_tlo` varchar(1) NOT NULL DEFAULT '',
  `log_no_abrev` varchar(36) DEFAULT NULL
);

CREATE TABLE `log_num_sec` (
  `log_nu` int(8) NOT NULL,
  `sec_nu_ini` varchar(10) NOT NULL DEFAULT '',
  `sec_nu_fim` varchar(10) NOT NULL DEFAULT '',
  `sec_in_lado` varchar(1) NOT NULL DEFAULT ''
);

CREATE TABLE `log_unid_oper` (
  `uop_nu` int(8) NOT NULL,
  `ufe_sg` varchar(2) NOT NULL DEFAULT '',
  `loc_nu` int(8) NOT NULL,
  `bai_nu` int(8) NOT NULL,
  `log_nu` int(8) DEFAULT NULL,
  `uop_no` varchar(100) NOT NULL DEFAULT '',
  `uop_endereco` varchar(100) NOT NULL DEFAULT '',
  `cep` varchar(8) NOT NULL DEFAULT '',
  `uop_in_cp` char(1) NOT NULL DEFAULT '',
  `uop_no_abrev` varchar(36) DEFAULT ''
);

CREATE TABLE `log_var_bai` (
  `bai_nu` int(8) NOT NULL,
  `vdb_nu` int(8) NOT NULL,
  `vdb_tx` varchar(72) NOT NULL DEFAULT ''
);

CREATE TABLE `log_var_loc` (
  `loc_nu` int(8) NOT NULL,
  `val_nu` int(8) NOT NULL,
  `val_tx` varchar(72) NOT NULL DEFAULT ''
);

CREATE TABLE `log_var_log` (
  `log_nu` int(8) NOT NULL,
  `vlo_nu` int(8) NOT NULL,
  `tlo_tx` varchar(36) NOT NULL DEFAULT '',
  `vlo_tx` varchar(150) NOT NULL DEFAULT ''
);
