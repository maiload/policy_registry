package ipList

import rego.v1

allowed_ips := [
    "192.168.1.1",
    "192.168.1.2",
    "192.168.1.3",
    "10.0.0.1",
    "10.0.0.2"
]

blocked_ips := [
    "192.168.100.1",
    "192.168.100.2",
    "10.10.10.10"
]

ip_whitelist := {
    "production": [
        "203.0.113.1",
        "203.0.113.2",
        "203.0.113.3"
    ],
    "development": [
        "192.168.1.0/24",
        "10.0.0.0/16"
    ],
    "staging": [
        "172.16.0.1",
        "172.16.0.2"
    ]
}

get_allowed_ips := allowed_ips

get_blocked_ips := blocked_ips

get_whitelist[environment] := ips if {
    environment := input.environment
    ips := ip_whitelist[environment]
}

is_ip_allowed if {
    input.ip in allowed_ips
}

is_ip_blocked if {
    input.ip in blocked_ips
}

ip_info[ip] := info if {
    ip := input.ip
    info := {
        "allowed": ip in allowed_ips,
        "blocked": ip in blocked_ips,
        "environments": [env | ip_whitelist[env][_] = ip; env := env]
    }
}

list_all_ips := {
    "allowed": allowed_ips,
    "blocked": blocked_ips,
    "whitelist": ip_whitelist
}