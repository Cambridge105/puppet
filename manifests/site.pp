node 'studioa-pi' {
  include role-studioa-pi
}
node 'studiob-pi' {
  include studiob_clock
}
node 'greenroom-pi' {
  include role-greenroom-pi
}
node 'rmc-rdell1' {
  include role_rivendell_client
}
