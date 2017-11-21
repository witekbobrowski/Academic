# Local Area Networking (Summer 2016)

### About

Here I will only attach some essential notes in the form of this readme. The class was strictly about designing and then configuring your own network within the university's laboratory using telnet and dedicated routers and switches.


### Logging in

```
$ telnet 171.30.33.router
login:
password:
$ configure private
```

### Network Configuration

##### Creating virtual routers
```
$ set routing-instances ROUTERX instance-type virtual-router
$ set routing-instances ROUTERX interface ge-0/0/1.XY
```
`X` - Your ID
`Y` - Network ID

##### Direct
```
$ set interfaces ge-0/0/1 vlan-tagging
$ set interfaces ge-0/0/1 unit XY vlan-id XY
$ set interfaces ge-0/0/1 unit XY family inet address 192.168.X.local/mask
```
Note: given address is random

##### Static
```
$ set routing-instances ROUTERX routing-options static route 192.168.X.direct/mask next-hop 192.168.X.n_local
```
`n_local` - Neighbours local address

##### Routing Information Protocol (RIP)
```
$ set routing-instances ROUTERX protocols rip group GROUP1
$ set routing-instances ROUTERX protocols rip group GROUP1 neighbor ge-0/0/1.XY

$ set policy-options policy-statement POLICY-X term D/S/R2RIP from protocol d/s/r
$ set policy-options policy-statement POLICY-X term D/S/R2RIP then accept

$ set routing-instances ROUTERX protocols rip group GROUP1 export POLICY-X

$ run show configuration policy-options
$ run show route advertising-protocol rip 192.168.X.n_local
$ run show route receive-protocol rip 192.168.X.n_local
```
`D` - Direct `S` - Static `R` - RIP

##### Open Shortest Path First (OSPF)
```
$ set routing-instances ROUTERX protocols ospf area 0 interface ge-0/0/1.XY

$ set interfaces lo0 unit X family inet address 1.1.X.router/32
$ set routing-instances ROUTERX interface lo0.X
$ set routing-instances ROUTERX protocols ospf area 0 interface lo0.X passive

$ run show ospf interface instance ROUTERX
```

##### Extra: Some useful telnet commands
```
$ commit
$ show|compare

$ run show interfaces terse
$ run show route table ROUTERX
$ run show configuration routing-instances ROUTERX

$ run ping 192.168.X.any_local routing-instance ROUTERX
```

### Computers Configuration

##### On router ("computer")
```
$ set routing-instances M-X-Y instance-type virtual-router
$ set routing-instances M-X-Y interface ge-0/0/P.0
$ set interfaces ge-0/0/Z unit 0 family inet address 192.N.X.H/24
$ set routing-instances M-X-Y routing-options static route 0/0 next-hop 192.N.X.1
```
`M` - Group member `N` - Group network `H` - Member host `P` - Router port

##### On switch
```
$ set vlans GROUP_X vlan-id XY
$ set interfaces ge-0/0/P unit 0 family ethernet-switching port-mode access vlan members GROUP_X

$ set interfaces ge-0/0/PR unit 0 family ethernet-switching port-mode trunk vlan members [GROUP_X … GROUP_X]
```
`P` - Switch port `PR` - Second router port `Y` - Group's VLAN-ID

##### On second router
```
$ set interfaces ge-C/0/P vlan-tagging
$ set interfaces ge-C/0/P unit XY vlan-id XY
$ set interfaces ge-C/0/P unit XY family inet address 192.N.X.1/24
```
`C` - Router's card `P` - Card's port `N` - Group network `Y` - Group's VLAN-ID

##### Extra: Some useful telnet commands
```
$  run show vlans
```
