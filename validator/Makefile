all: validator.byte nat_fspec.cmo bridge_fspec.cmo

validator.byte: .PHONY
	corebuild -no-hygiene -use-menhir -lib dynlink validator.byte -use-ocamlfind

nat_fspec.cmo: _build/nat_fspec.cmo
	cp _build/nat_fspec.cmo ./

bridge_fspec.cmo: _build/bridge_fspec.cmo
	cp _build/bridge_fspec.cmo ./

_build/nat_fspec.cmo: .PHONY
	corebuild -no-hygiene -lib dynlink nat_fspec.cmo

_build/bridge_fspec.cmo: .PHONY
	corebuild -no-hygiene -lib dynlinc bridge_fspec.cmo

.PHONY:

clean:
	rm _build -r
	rm nat_fspec.cmo
	rm validator.byte
