package policies.rbac

import rego.v1

default allow := false

roles_permissions := {
    "admin": [
        {"resource": "*", "action": "*"}
    ],
    "editor": [
        {"resource": "articles", "action": "read"},
        {"resource": "articles", "action": "write"},
        {"resource": "articles", "action": "update"}
    ],
    "viewer": [
        {"resource": "articles", "action": "read"},
        {"resource": "comments", "action": "read"}
    ]
}

allow if {
    some permission in roles_permissions[input.user.role]
    permission.resource == "*"
    permission.action == "*"
}

allow if {
    some permission in roles_permissions[input.user.role]
    permission.resource == input.resource
    permission.action == input.action
}

allow if {
    some permission in roles_permissions[input.user.role]
    permission.resource == "*"
    permission.action == input.action
}

allow if {
    some permission in roles_permissions[input.user.role]
    permission.resource == input.resource
    permission.action == "*"
}