# Files

* expiring_map.tex - specification of a sample network data structure - expiring map
* coq/ - proofs for sample programs written in coq:
 * sqr.v - natural number square root coq implementation
 * sqr2.v - the same implementation with a more concise proof
 * sqrt.c - c implementation of square root. It reflects the Coq's implementation, so it is easy to proof equivalence. Use clightgen to generate sqrt.v (part of CompCert distribution)
 * sqrt.v - clightgen-generated file from sqrt.c
 * verif_sqrt.v - VST proof of equivalence of sqrt.v to sqr.v 
 * verif_sqrt2.v - an attempt to proof equivalence of sqrt.v to sqr2.v
 * assoc.c - simple circular array implementation
 * assoc.v - the automatic clightgen translation of assoc.c into Coq IR
 * assoc_spec.v - CoQ high level specification, middle level implementation and correspondence proof
 * verif\_assoc.v - VST specification and proof of equality of assoc.v and assoc_spec.v's middle level implementation
 * map.c - simiple array-based map int32 -> int32 map with a hardcoded capacity of 100 cells
 * map.v - clightgen-generated CompCert CoQ IR
 * map_spec.v - FOL spec of map, a middle-level implementation in CoQ and a equivalence proof
 * verif\_map.v - VST spec and proof of map.v-to-map_spec.v equivalence

# Use
To make sure, that sqrt.c indeed corresponds to sqr.v which conforms the specification sqrt(n)^2 <= n < (sqrt(n)+1)^2, you will need [Coq](https://coq.inria.fr/), [Compcert](http://compcert.inria.fr/download.html) and [VST](http://vst.cs.princeton.edu/), [Proofgeneral](http://proofgeneral.inf.ed.ac.uk/).

1. To install coq and proofgeneral in Ubuntu, use 
  ```
      $ sudo apt-get install coq proofgeneral
  ```
  Or download it from the links, supplied above.
  Compcert and VST are in the standard Ubunto repo, so you have to download, unpack and build them by hand.

2. Compcert:
  ```bash
      $ wget http://compcert.inria.fr/release/compcert-2.4.tgz
      $ tar -xf compcert-2.4.tgz
      $ cd compcert-24 && ./configure ia32-linux && make -j8
      $ export PATH=$PATH:$PWD
  ```

3. VST:
  ```bash
      $ wget http://vst.cs.princeton.edu/download/vst-1.5.tgz
      $ tar -xf vst-1.5.tgz
      $ cd vst
  ```
  See the BUILD_ORGANIZATION file in vst for instruction on how to build it. If `vst` is is in the same parent directory as `compcert-2.4`, then:
  ```bash
      $ echo "COMPCERT=../compcert-2.4" > CONFIGURE
      $ make -j8
  ```

4. Now you have to set up your proofgeneral. Add to your `~/.emacs` file:
  ```elisp
  ;; proofgeneral CoQ mode:
  (setq vst-base-path (expand-file-name "--- /path/to/vst ---"))
  (setq compcert-install-path (expand-file-name "--- /path/to/compcert ---"))
  (setq coq-compile-before-require 1)

  (setq coq-load-path `((,(concat vst-base-path "/msl") "msl")
                        (,(concat vst-base-path "/sepcomp") "sepcomp")
                        (,(concat vst-base-path "/veric") "veric")
                        (,(concat vst-base-path "/floyd") "floyd")
                        (,(concat vst-base-path "/progs") "progs")
                        (,compcert-install-path "compcert")))
  ```
  Where `"--- /path/to/vst ---"` is a string, containing a path to the directory where you built vst, and `"--- /path/to/compcert ---"` is a string with a path to your compcert installation. If everything is done correctly, you should be able to verify the proof now.

5. Convert `sqrt.c` into Compcert IR:
  ```bash
      $ cd coq
      $ clightgen sqrt.c
  ```

6. Run Proofgeneral:
  ```bash
      $ proofgeneral verif_sqrt.v
  ```

On the first run, Coq will need to compile everything.
Use `next` button on the top panel (or `C-c C-n` - Ctrl+c, then Ctrl+n), to go through the proof step-by-step. First step may take a long time up to hours, because, here Coq compiles everything it can reach.
   