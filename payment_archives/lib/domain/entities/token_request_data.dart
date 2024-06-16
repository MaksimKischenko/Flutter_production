enum TokenRequestData {
  grantTypePassword('password'),
  grantTypeRefresh('refresh_token'),
  clietnId('ps_archive_ui');

  final String name;

  const TokenRequestData(this.name);
}
