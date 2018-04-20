acl internal {

  # Trusted NYHQ NAT
  "170.149.100.0"/25;

  # NFHQ/ORF1 (Norfolk/SSC)
  "170.149.240.0"/25;

  # Hong Kong NP + SW Users
  "58.177.176.84"/32;
  "202.147.18.187"/32;

  # Washington DC Users
  "208.37.145.16"/29;
  "50.234.243.0"/29;

  # older DC, remove after WAN cutover is complete, DV-1250
  "206.205.234.166"/32;
  "50.232.13.178"/32;

  # London Users
  "78.25.224.254"/32;
  "80.4.179.80"/28;

  # Paris Users (La defense)
  "84.14.214.162"/32;
  "83.167.155.194"/32;

  # Paris Users (Courbevoie)
  "83.167.54.1"/32;
  "195.101.111.1"/32;

  # Paris Datacenter
  "194.2.154.34"/32;
  "84.14.227.131"/32;
  "88.84.145.194"/32;

  # Singapore Users
  "203.125.89.19"/32;

  # Zurich Users
  "212.147.32.137"/32;

  # Frankfurt Users
  "217.92.49.9"/32;

  # Dubai users
  "94.200.99.174"/32;

  # PRD.EWR1 HTTP/HTTPs traffic
  "170.149.168.65"/32;
  "170.149.168.66"/32;

  # STG.EWR1  HTTP/HTTPs traffic
  "170.149.164.65"/32;
  "170.149.164.66"/32;

  # PRD.SEA1 HTTP/HTTPs traffic
  "170.149.174.65"/32;
  "170.149.174.66"/32;

  # STG.SEA1 HTTP/HTTPs traffic
  "170.149.174.33"/32;
  "170.149.174.34"/32;

  # PRD.LGA1 HTTP/HTTPs traffic
  "170.149.188.65"/32;
  "170.149.188.66"/32;

  # STG.LGA1  HTTP/HTTPs traffic
  "170.149.186.65"/32;
  "170.149.186.66"/32;
}
