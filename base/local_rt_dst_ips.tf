locals {
  # example using checkip.amazonaws.com
  # $ dig +short checkip.amazonaws.com |tail -n6
  rt_dst_ips = [
    "52.202.139.131/32",
    "34.196.82.108/32",
    "52.0.208.170/32",
    "52.200.125.74/32",
    "34.233.102.38/32",
    "18.233.42.138/32",
  ]
}
