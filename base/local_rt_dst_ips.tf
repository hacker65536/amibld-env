locals {
  # example using checkip.amazonaws.com
  # $ dig +short checkip.amazonaws.com |tail -n6
  # $ dig +short checkip.amazonaws.com |tail -n1
  # timeout...
  rt_dst_ips = [
    "52.200.125.74/32",
    #"52.206.161.133/32",
    #"52.202.139.131/32",
    #"34.233.102.38/32",
    #"18.211.215.84/32",
    #"52.6.79.229/32",

  ]
}
