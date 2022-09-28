;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2014, 2015, 2016 Ricardo Wurmus <rekado@elephly.net>
;;; Copyright © 2015, 2016 Ben Woodcroft <donttrustben@gmail.com>
;;; Copyright © 2015, 2016 Pjotr Prins <pjotr.guix@thebird.nl>
;;; Copyright © 2015 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2016 Roel Janssen <roel@gnu.org>
;;; Copyright © 2016 Efraim Flashner <efraim@flashner.co.il>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

;;; Author: olav.smorholm@cern.ch

(define-module (cern)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system r)
  #:use-module (guix build-system ruby)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages cpio)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages doxygen)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages java)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mit-krb5)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages openldap)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages tcsh)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages zip)
  #:use-module (srfi srfi-1))


; why 2.2.0.8 in alidist build scripts?
; https://github.com/alisw/alidist/blob/IB/v5-08/prod/clhep.sh
(define-public clhep
  (package
    (name "clhep")
    (version "2.2.0.4")
    (source (origin
      (method git-fetch)
      (uri (git-reference 
	     (url "http://git.cern.ch/pub/CLHEP")
	     (commit "CLHEP_2_2_0_4")))
      (sha256
	(base32
	  "1f2ji5mxvr0rjzwnd6l4mygvypwfwz4pmvc6ydpmn47kqsrk230h"))))
    (build-system cmake-build-system)
    (native-inputs
           `(("gcc" , gcc)))
    (arguments
     '(#:test-target "test"
       #:parallel-build? #f
       #:configure-flags '("-DCLHEP_BUILD_CXXSTD=-std=c++11"
			   "-DCLHEP_BUILD_DOCS=ON")))
    (home-page "https://http://proj-clhep.web.cern.ch/")
    (synopsis "A Class Library for High Energy Physics")
    (description "The CLHEP project was proposed by Leif Lönnblad at
CHEP 92. It is intended to be a set of HEP-specific foundation and
utility classes such as random generators, physics vectors, geometry
and linear algebra. CLHEP is structured in a set of packages independent
of any external package (interdependencies within CLHEP are allowed
under certain conditions). 
")
    (license license:gpl3+)))

(define-public xerces
  (package
    (name "xerces")
    (version "3.1.3")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://mirror.catn.com/pub/apache/"
			  "xerces/c/3/sources/xerces-c-"
			  version ".tar.xz"))
      (sha256
	(base32
	  "152ws8an98pdcpvjln6gpa6vm2mw6cpcxcj1xz3p6grkvd1f8nnk"))))
    (build-system gnu-build-system)
    (inputs
      `(("curl", curl)
	("pkg-config", pkg-config)))
    (arguments
      '(#:tests? #f
	#:configure-flags '("--with-pkgconfig"
			    "--with-icu"
			    "--with-curl")))
    (home-page "https://xerces.apache.org/xerces-c/")
    (synopsis "Xerces-C++ is a validating XML parser")
    (description "Xerces-C++ is a validating XML parser written
in a portable subset of C++. Xerces-C++ makes it easy to give
your application the ability to read and write XML data.
")
    (license license:asl2.0)))

;c++98 default, align with root? safe? newer version might be better
;todo: move data to seperate package all together. 
(define-public geant4
  (package
    (name "geant4")
    (version "10.01.p03")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://geant4.cern.ch/geant4/support/source/"
			  "geant4." version ".tar.gz"))
      (sha256
	(base32
	  "0x5ipf94qpy0dm40aylh3pgvi55h5yz5pajfxxl7kzf4bcxr965i"))))
    (build-system cmake-build-system)
    (outputs '("out" "data"))
    (inputs
      `(("xerces", xerces)
        ("clhep", clhep)
	("expat", expat)
	("tcsh", tcsh)
	("g4ndl"
	 ,(origin
	    (method url-fetch)
	    (uri "http://geant4.cern.ch/support/source/G4NDL.4.5.tar.gz")
	    (sha256
	      (base32
		"13nzvig8dx2yy0gc663a1jxk829xz1byzir9hayg525742jjiafb"))))
	("g4mlow"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4EMLOW.6.48.tar.gz")
            (sha256
              (base32
                "1izivwbprcj2qcwfbx4bkf0v3a2jcmc4s910bf2yii5wrf4bw5cq"))))
	("g4pe"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4PhotonEvaporation.3.2.tar.gz")
            (sha256
              (base32
                "1m4j0irrrqbcr4x47x3vanlhsvh08dzf35ch7kl0qqda8w54bv9m"))))
	("g4rd"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4RadioactiveDecay.4.3.1.tar.gz")
            (sha256
              (base32
                "11bixr89l8nhdzw16crb9d4xj1racxyy488q069zvw4lvc2jx8gg"))))
	("g4nxs"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4NEUTRONXS.1.4.tar.gz")
            (sha256
              (base32
                "1zd8fg55q436q8vr85njdsvis5jg5m086qmjcpfhs1pbsxl8icsp"))))
	("g4pii"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4PII.1.3.tar.gz")
            (sha256
              (base32
                "09p92rk1sj837m6n6yd9k9a8gkh6bby2bfn6k0f3ix3m4s8as9b2"))))
	("realsurf"
	 ,(origin
	    (method url-fetch)
	    (uri "http://geant4.cern.ch/support/source/RealSurface.1.0.tar.gz")
	    (sha256
	      (base32
		"1c90j1kl0rwil65waiwk68wq081fjs0jc7rzj3nq09qdc032ab9y"))))
	("g4sd"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4SAIDDATA.1.1.tar.gz")
            (sha256
              (base32
                "0zzdl1yjpa1br248xa34yankc395rng61zjh529128xn7nldk353"))))
	("g4abla"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4ABLA.3.0.tar.gz")
            (sha256
              (base32
                "053h4wfj80rikxps6glb2krlzyj5iq4690zd2j7pfja9kg64vzcr"))))
	("g4ensdf"
         ,(origin
            (method url-fetch)
            (uri "http://geant4.cern.ch/support/source/G4ENSDFSTATE.1.2.1.tar.gz")
            (sha256
              (base32
                "1851hgi3qq454n7h7w7fc4zjz3na6af1w12kjza29zl7jgg0fj18"))))
	("g4tendl"
	 ,(origin
	    (method url-fetch)
	    (uri "http://geant4.cern.ch/support/source/G4TENDL.1.0.tar.gz")
	    (sha256
	      (base32
		"07gbqjj37a6y1lzl9i2kifj300jzs71km3jjgb2za17qa75j5aw1"))))))
    (arguments
     '(#:tests? #f
       #:configure-flags (list
		"-DGEANT4_BUILD_CXXSTD=c++11"
		"-DCMAKE_INSTALL_LIBDIR=lib"
		"-DGEANT4_INSTALL_DATA=OFF"
		"-DGEANT4_USE_SYSTEM_CLHEP=ON"
		"-DGEANT4_USE_GDML=ON"
		(string-append "-DGEANT4_INSTALL_DATADIR="
		(assoc-ref %outputs "data")
		"/share/geant4/data"))
       #:phases
        (modify-phases %standard-phases
	  (add-after 'install 'install-g4data
	    (lambda* (#:key inputs outputs #:allow-other-keys)
		(begin
		  (mkdir-p (string-append (assoc-ref outputs "data") "/share/geant4/data"))
		  (chdir (assoc-ref outputs "data"))
		   (with-directory-excursion (string-append "share/geant4/data")
			 (copy-file (assoc-ref inputs "g4ndl") "g4ndl.tar.gz")
			 (copy-file (assoc-ref inputs "g4mlow") "g4mlow.tar.gz")
			 (copy-file (assoc-ref inputs "g4pe") "g4pe.tar.gz")
			 (copy-file (assoc-ref inputs "g4rd") "g4rd.tar.gz")
			 (copy-file (assoc-ref inputs "g4nxs") "g4nxs.tar.gz")
			 (copy-file (assoc-ref inputs "g4pii") "g4pii.tar.gz")
			 (copy-file (assoc-ref inputs "realsurf") "realsurf.tar.gz")
			 (copy-file (assoc-ref inputs "g4sd") "g4sd.tar.gz")
			 (copy-file (assoc-ref inputs "g4abla") "g4abla.tar.gz")
			 (copy-file (assoc-ref inputs "g4ensdf") "g4ensdf.tar.gz")
			 (copy-file (assoc-ref inputs "g4tendl") "g4tendl.tar.gz")
			 (zero? (system* "tar" "xvf" "g4ndl.tar.gz"))
			 (zero? (system* "tar" "xvf" "g4mlow.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4pe.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4rd.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4nxs.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4pii.tar.gz"))
			 (zero?	(system* "tar" "xvf" "realsurf.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4sd.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4abla.tar.gz"))
			 (zero?	(system* "tar" "xvf" "g4ensdf.tar.gz"))
			 (zero? (system* "tar" "xvf" "g4tendl.tar.gz"))
			 (for-each delete-file (find-files "." "\\.tar.gz")))))))))
    (home-page "https://geant4.cern.ch/")
    (synopsis "Simulation of the passage of particles through matter")
    (description "Geant4 is a toolkit for the simulation of the passage
of particles through matter. Its areas of application
include high energy, nuclear and accelerator physics, as
well as studies in medical and space science. 
")
    (license license:gpl3+)))

(define-public geant4_vmc
  (package
    (name "geant4_vmc")
    (version "3.3") ;new than grid
    (source (origin
      (method git-fetch)
      (uri (git-reference
	     (url "http://root.cern.ch/git/geant4_vmc.git")
	     (commit "v3-3")))
      (sha256
	(base32
	  "06g8m564w0scpgw635jpzqi9wwdqyh8jiq0zxxm8k5fdj9ryj0g3"))))
      (build-system cmake-build-system)
      (inputs
	`(("geant4", geant4)
	  ("vgm", vgm)
	  ("root", root)))
      (arguments
	`(#:tests? #f
	  #:configure-flags '("-DGeant4VMC_USE_VGM=ON"
			      "-DCMAKE_INSTALL_LIBDIR=lib")))
      (home-page "https://root.cern.ch/vmc")
      (synopsis "The Virtual Monte Carlo (VMC)")
      (description "The Virtual Monte Carlo (VMC) allows to run
different simulation Monte Carlo without changing the user code.")
      (license license:gpl2)))


(define-public vgm
  (package
    (name "vgm")
    (version "4.3")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://ivana.home.cern.ch/ivana/"
			  "vgm." version ".tar.gz"))
      (sha256
	(base32
	  "0w6r1x9z5p9m09qmq6fqfk4ymx0nwp97vzyhjbgzx6jfm24f0pww"))))
    (build-system cmake-build-system)
    (inputs
      `(("geant4", geant4)
	("root", root)
	("clhep", clhep)))
    (arguments
      `(#:tests? #f
        #:configure-flags `("-DINSTALL_EXAMPLES=ON" "-DWITH_EXAMPLES=ON"
			    "-DCMAKE_INSTALL_LIBDIR=lib"
	           ,(string-append "-DCLHEP_DIR=" (assoc-ref %build-inputs "clhep")))))
    (home-page "http://ivana.home.cern.ch/ivana/VGM.html")
    (synopsis "The Virtual Geometry Model")
    (description "VGM has been developed as a generalization
of the existing convertors roottog4, g4toxml provided within Geant4 VMC.")
    (license license:gpl2)))

(define-public xrootd
  (package
    (name "xrootd")
    (version "3.3.6")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://www.xrootd.org/download/v"
			  version "/" "xrootd-" version ".tar.gz"))
      (sha256
	(base32
	  "05vjdl2a0bq355ar8xnnl74h3xhw7lgppsakk7sbr5jjky8nsr86"))))
    (build-system cmake-build-system)
    (native-inputs
           `(("gcc", gcc)))
    (propagated-inputs
           `(("openssl", openssl)
	     ("mit-krb5", mit-krb5)
	     ("readline", readline)
	     ("zlib", zlib)
	     ("perl", perl)
	     ("libevent", libevent)
	     ("fuse", fuse)))
    (arguments
      `(#:tests? #f
	#:configure-flags '("-DCMAKE_INSTALL_LIBDIR=lib")))
    (home-page "https:/www.xrootd.org/")
    (synopsis "Scalable fault tolerant access to data repositories of many kinds")
    (description "The XROOTD project aims at giving high performance, scalable
fault tolerant access to data repositories of many kinds
")
    (license license:lgpl3+)))

(define-public xalienfs
  (package
    (name "xalienfs")
    (version "1.0.14r1")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://alitorrent.cern.ch/src/xalienfs/"
			    "xrootd-xalienfs-" version ".tar.gz"))
      (sha256
        (base32
          "1yg7zwli3frws0rldv1h7d0wzm8aplghg9idyqkm7zrl220mysba"))))
    (propagated-inputs
           `(("swig", swig)
	     ("perl", perl)
	     ("openssl", openssl)
	     ("readline", readline)
	     ("xrootd", xrootd)))
    (native-inputs
           `(("gcc", gcc)))
    (build-system gnu-build-system)
    (arguments
      `(#:configure-flags '("--enable-perl-module"
			    "--enable-build-server"
			    "--with-swig")))
    (home-page "http://alitorrent.cern.ch/src/xalienfs/")
    (synopsis "something alien needs")
    (description "something quite old")
    (license license:gpl1)))

(define-public perl-archive-extract
  (package
    (name "perl-archive-extract")
    (version "0.76")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
               "https://cpan.metacpan.org/authors/id/B/BI/BINGOS/Archive-Extract-"
               version
               ".tar.gz"))
        (sha256
          (base32
            "1z2chz7a5q6024h9rmzpq0z53x0jw7983ia5k1yxsih3lw60irws"))))
    (build-system perl-build-system)
    (home-page
      "http://search.cpan.org/dist/Archive-Extract")
    (synopsis "Generic archive extracting mechanism")
    (description "needed for alien-perl")
    (license (package-license perl))))

(define-public perl-module-build
  (package
    (name "perl-module-build")
    (version "0.4218")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
               "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-"
               version
               ".tar.gz"))
        (sha256
          (base32
            "1l60hyhpwk6hl39wms4msl6yc6ypfw528yay9a4nya9zk99amw0y"))))
    (build-system perl-build-system)
    (home-page
      "http://search.cpan.org/dist/Module-Build")
    (synopsis "Build and install Perl modules")
    (description "needed for alien-perl")
    (license (package-license perl))))

(define-public perl-alien-root
  (package
    (name "perl-alien-root")
    (version "v5.34.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
               "mirror://cpan/authors/id/S/SM/SMUELLER/Alien-ROOT-"
               version
               ".tar.gz"))
        (sha256
          (base32
            "0rr3i9a4wfdwqg40g89jlyz1h84zzasplsfk5rd30k01xk41aazq"))))
    (build-system perl-build-system)
    (native-inputs
      `(("perl-archive-extract" ,perl-archive-extract)
        ("perl-module-build" ,perl-module-build)))
    (propagated-inputs
      `(("root", root)))
    (home-page
      "http://search.cpan.org/dist/Alien-ROOT")
    (synopsis
      "Utility package to install and locate CERN's ROOT library")
    (description "alien-perl")
    (license #f)))

(define-public fastjet
  (package
    (name "fastjet")
    (version "3.1.3")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://fastjet.fr/repo/"
			  "fastjet-" version ".tar.gz"))
      (sha256
	(base32
	  "03g4cmy0ikwns4y7nvdni5jh67k2avd1xl4p0f4k1v4sr2hc42cq"))))
    (build-system gnu-build-system)
    (inputs
      `(("cgal", cgal)
        ("boost", boost)
        ("gmp", gmp)
        ("mpfr", mpfr)))
    (arguments
      `(#:tests? #f
	#:configure-flags `("--enable-cgal"
			    "--enable-shared"
			    "--enable-allcxxplugins"
                            ,(string-append "--with-cgaldir="
                                            (assoc-ref %build-inputs "cgal")))))
    (home-page "http://fastjet.fr/")
    (synopsis "A software package for jet finding in pp and e+e− collisions")
    (description "A software package for jet finding in pp and e+e− collisions.
It includes fast native implementations of many sequential recombination
clustering algorithms, plugins for access to a range of cone jet finders
and tools for advanced jet manipulation.")
    (license license:gpl2)))

;move into fastjet pkg
;
(define-public fjcontrib
  (package
    (name "fjcontrib")
    (version "1.017")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://fastjet.hepforge.org/contrib/downloads/"
                          "fjcontrib-" version ".tar.gz"))
      (sha256  
        (base32
          "0b1nabimvyvd309bmpbdx6a37gc5fxpxzh9wz2ys3ab3gy5inwbg"))))
    (build-system gnu-build-system)
    (propagated-inputs
      `(("fastjet", fastjet)))
    (inputs
      `(("cgal", cgal)
        ("boost", boost)
        ("gmp", gmp)
        ("mpfr", mpfr)))
   (arguments
    `(#:tests? #f
      #:phases
       (modify-phases %standard-phases
         (replace 'configure
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               (zero? (system*
                       "./configure"
                       (string-append "--prefix=" out)))))))))

    (home-page "http://fastjet.hepforge.org/contrib/")
    (synopsis "3rd party extensions of FastJet")
    (description "The fastjet-contrib space is intended to provide
a common location for access to 3rd party extensions of FastJet.")
    (license license:gpl2)))

(define-public cctools
  (package
    (name "cctools")
    (version "5.3.1")
    (source (origin
      (method git-fetch)
      (uri (git-reference
             (url "http://github.com/cooperative-computing-lab/cctools")
             (commit "release/5.3.1")))
      (sha256
        (base32
          "07xzkb63zfcp4izklkq67bncxgk43974wzn8bdm5hixsn95fipm3"))))
    (build-system gnu-build-system)
    (inputs
      `(("swig", swig)
        ("zlib", zlib)
        ("perl", perl)))
    (arguments
      `(#:tests? #f
        #:phases
         (modify-phases %standard-phases
           (replace 'configure
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let ((out (assoc-ref outputs "out"))
                     (swig (assoc-ref inputs "swig"))
                     (zlib (assoc-ref inputs "zlib")))
                 (zero? (system*
                         "./configure"
                         (string-append "--prefix=" out)
                         (string-append "--with-swig-path=" swig)
                         (string-append "--with-zlib-path=" zlib)))))))))
    (home-page "https://github.com/cooperative-computing-lab/cctools")
    (synopsis "The Cooperative Computing Tools (cctools) enable large scale distributed computations")
    (description "The Cooperative Computing Tools (cctools) is a software
package for enabling large scale distributed computing
on clusters, clouds, and grids.  It is used primarily for
attacking large scale problems in science and engineering.")
    (license license:gpl2)))

;TODO:
; requires binary install to configure and install
; must use alien-perl or fix Makefile.PL
;
;(define-public alien
;  (package
;    (name "alien")
;    (version "2.19")
;    (source (origin
;      (method url-fetch)
;      (uri (string-append "http://pcalienbuild4.cern.ch:8880/x86_64-unknown-linux-gnu/"
;                          version "/download/" name  ".all.tar.gz"))
;      (sha256
;        (base32
;          "1ynkf8j9jyrgaj9kih8ar3cpkp5z9jdnbx5rly0fpw66z1fa9k5d"))))
;    (build-system cmake-build-system)
;    (arguments
;     `(#:tests? #f))
;    (home-page "https://geant4.cern.ch/")
;    (synopsis "AliEn is the ALICE middleware for GRID")
;    (description "A horrible piece of hack
;")
;    (license license:gpl3+)))

(define-public hepmc
  (package
    (name "hepmc")
    (version "2.06.09")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://lcgapp.cern.ch/project/simu/HepMC/download/"
			  "HepMC-" version ".tar.gz"))
      (sha256
	(base32
	  "020sc7hzy7d6d1i6bs352hdzy5zy5zxkc33cw0jhh8s0jz5281y6"))))
    (build-system gnu-build-system)
    (inputs
      `(("gcc", gcc)
	("clhep", clhep)))
    (arguments
      `(#:tests? #f
	#:configure-flags '("--with-CLHEP"
			    "--with-momentum=GEV"
			    "--with-length=MM")))
    (home-page "http://lcgapp.cern.ch/project/simu/HepMC/")
    (synopsis "C++ Event Record for Monte Carlo Generators")
    (description "The HepMC package is an object oriented event record written in C++
for High Energy Physics Monte Carlo Generators. Many extensions from HEPEVT,
the Fortran HEP standard, are supported: the number of entries is unlimited,
spin density matrices can be stored with each vertex, flow patterns (such as color)
can be stored and traced, integers representing random number generator states can be
stored, and an arbitrary number of event weights can be included. Particles and
vertices are kept separate in a graph structure, physically similar to a physics event.
The added information supports the modularisation of event generators. The package
has been kept as simple as possible with minimal internal/external dependencies.
Event information is accessed by means of iterators supplied with the package.")
    (license license:gpl2)))

;would strongly prefer upstream, rathern than the alisw for
; todo
(define-public pythia6
  (package
    (name "pythia6")
    (version "4.16")
    (source (origin
      (method git-fetch)
      (uri (git-reference
	     (url "https://github.com/alisw/pythia6.git")
             (commit "alice/416")))
      (sha256
        (base32
          "0y2pqlzld7lziambksdpapf4gml5lpvgqk8q5q9q90q8s6j51kgx"))))
    (build-system cmake-build-system)
    (inputs
      `(("gfortran", gfortran)))
    (arguments
      `(#:tests? #f))
    (home-page "http://pythia6.hepforge.org/")
    (synopsis "PYTHIA is a program for the generation of high-energy physics events")
    (description "PYTHIA is a program for the generation of high-energy
physics events, i.e. for the description of collisions at high energies
between elementary particles such as e+, e-, p and pbar in various combinations.
It contains theory and models for a number of physics aspects, including
hard and soft interactions, parton distributions, initial- and final-state
parton showers, multiparton interactions, fragmentation and decay. It is
largely based on original research, but also borrows many formulae and
other knowledge from the literature.
")
    (license license:gpl2)))

(define-public pythia8
  (package
    (name "pythia8")
    (version "210")
    (source (origin
      (method url-fetch)
      (uri (string-append "http://home.thep.lu.se/~torbjorn/pythia8/"
			  name version ".tgz"))
      (sha256
	(base32
	  "0dda1gngwpanhd2q46igkci364hcymjs17ds2mhjhni325h4qmm2"))))
    (build-system gnu-build-system)
    (native-search-paths
      (list (search-path-specification
              (variable "PYTHIA8DATA")
              (files '("share/Pythia8/xmldoc")))))
    (propagated-inputs
      `(("zlib", zlib)))
    (inputs
      `(("rsync", rsync)))
    (arguments
      `(#:tests? #f
	#:configure-flags '("--with-gzip"
			    "--enable-shared")))
    (home-page "http://home.thep.lu.se/~torbjorn/Pythia.html")
    (synopsis "PYTHIA is a program for the generation of high-energy physics events")
    (description "PYTHIA is a program for the generation of high-energy
physics events, i.e. for the description of collisions at high energies
between elementary particles such as e+, e-, p and pbar in various combinations.
It contains theory and models for a number of physics aspects, including
hard and soft interactions, parton distributions, initial- and final-state
parton showers, multiparton interactions, fragmentation and decay. It is
largely based on original research, but also borrows many formulae and
other knowledge from the literature.
")
    (license license:gpl2)))

(define-public root
  (package
    (name "root")
    (version "5.34.36")
    (source (origin
      (method url-fetch)
      (uri (string-append "https://root.cern.ch/download/"
                          "root_v" version ".source.tar.gz"))
      (sha256
        (base32
          "1kbx1jxc0i5xfghpybk8927a0wamxyayij9c74zlqm0595gqx1pw"))))
    (build-system cmake-build-system)
    (native-search-paths
      (list (search-path-specification
              (variable "ROOTSYS")
              (files '("")))))
    (inputs
           `(("libxml2", libxml2)
	     ("freetype", freetype)
	     ("graphviz", graphviz)
             ("expat", expat)
             ("pcre", pcre)
	     ("mit-krb5", mit-krb5)
	     ("openldap", openldap)
	     ("ftgl", ftgl)
	     ("glew", glew)
	     ("glu", glu)
	     ("libx11", libx11)
	     ("libice", libice)
	     ("libsm", libsm)
	     ("xproto", xproto)
	     ("libxpm", libxpm)
	     ("libxft", libxft)
	     ("libxext", libxext)
	     ("libpng", libpng)
	     ("mesa", mesa)
	     ("qt", qt-4)
	     ("postgresql", postgresql)
	     ("unixodbc", unixodbc)
             ("pkg-config", pkg-config)
	     ("jemalloc", jemalloc)
	     ("sqlite", sqlite)
	     ("openssl", openssl)
             ("pythia6", pythia6)
             ("zlib", zlib)
	     ("fftw", fftw)
	     ("gsl", gsl)
	     ("vdt", vdt)
	     ("xrootd", xrootd)
	     ("tcsh", tcsh)
	     ("davix", davix)
	     ("libafterimage", libafterimage)
	     ("cfitsio", cfitsio)
	     ("python", python-2)))
    (arguments
     '(#:tests? #f
       #:configure-flags 
                     (list "-Dcxx11=ON" "-Drpath=ON" "-Djemmaloc=ON"
                           "-DCMAKE_INSTALL_LIBDIR=lib" "-Dminuit2=ON"
                           "-Dx11=ON" "-Dqt=ON" "-Dtmva=OFF" "-Droofit=ON"
			   "-Dbuiltin_afterimage=OFF" "-Dastiff=ON"
			   "-Dbuiltin_ftgl=OFF" "-Dopengl=ON" "-Dmathmore=ON"
			   "-Dbuiltin_glew=OFF" "-Dvdt=ON" "-Dhttp=ON"
                           "-Dbuiltin_gsl=OFF" "-Dbuiltin_zlib=OFF"
                           "-Dpythia6=ON" "-Dpythia6_nolink=ON"
                           "-Dpythia8=OFF" "-Dshadowpw=OFF" "-Dsoversion=ON"
			   "-Ddavix=ON" "-Dcfitsio=ON"
			   (string-append "-DOPENGL_INCLUDE_DIR="
					  (assoc-ref %build-inputs "mesa")
					  "/include")
			   (string-append "-DOPENGL_gl_LIBRARY="
					  (assoc-ref %build-inputs "mesa")
					  "/lib/libGL.so")
			   (string-append "-DOPENGL_glu_LIBRARY="
					  (assoc-ref %build-inputs "glu")
					  "/lib/libGLU.so"))))
    (home-page "https://root.cern.ch/")
    (synopsis "ROOT is a framework for data processing, born at CERN")
    (description "A modular scientific software framework. It provides
all the functionalities needed to deal with big data processing,
statistical analysis, visualisation and storage. It is mainly written
in C++ but integrated with other languages such as Python and R.
")
    (license license:gpl3+)))

(define-public davix
  (package
  (name "davix")
  (version "0.6.3")
  (source (origin
    (method git-fetch)
    (uri (git-reference
           (url "https://github.com/cern-it-sdc-id/davix.git")
	   (commit "R_0_6_3")))
    (sha256
      (base32
        "1hznvljad2mid74mxmzsyl7m0d8kk1b27m5izdvfqi696gp3q30z"))))
   (build-system cmake-build-system)
   (inputs
     `(("pkg-config", pkg-config)
       ("xdg-utils", xdg-utils)
       ("boost", boost)
       ("doxygen", doxygen)
       ("libxml2", libxml2)
       ("openssl", openssl)))
   (arguments
     `(#:tests? #f
       #:configure-flags '("-DSTATIC_LIBRARY=ON" "-DSHARED_LIBRARY=ON")))
   (home-page "https://dmc.web.cern.ch/projects/davix/home")
   (synopsis "The davix project aims to make file management over HTTP-based protocols simple")
   (description "The davix project aims to make file management over HTTP-based protocols simple.
The focus is on high-performance remote I/O and data management of large collections of files.
Currently, there is support for the WebDav (link is external), Amazon S3 (link is external),
Microsoft Azure (link is external), and HTTP (link is external) protocols.")
   (license license:gpl2)))

; TODO: delete files prior to build instead of this bad patch

(define-public cfitsio
  (package
  (name "cfitsio")
  (version "3390")
  (source (origin
    (method url-fetch)
    (uri (string-append "http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio"
			version ".tar.gz"))
    (sha256
      (base32
        "02gllydm63irwbqqisa3mrskw1fphm5rlplglz3mq9whi3rxilv2"))
    (patches (list (search-patch "cfitsio-zlib.patch")))))
   (build-system gnu-build-system)
   (inputs
     `(("bzip2", bzip2)
       ("zlib", zlib)
       ("pkg-config", pkg-config)
       ("gfortran", gfortran)))
   (arguments
     `(#:tests? #f 
       #:configure-flags (list "--enable-reentrant"
			   (string-append "CFLAGS=-g -O2 -Wl,-rpath="
					  (assoc-ref %outputs "out")
					  "/lib"))
       #:phases
       (modify-phases %standard-phases
	 (replace 'build
	   (lambda _ (and (zero? (system* "make"))
	                  (zero? (system* "make" "shared"))
	                  (zero? (system* "make" "fpack"))
	                  (zero? (system* "make" "funpack"))
	                  (zero? (system* "make" "fitscopy")))))
         (replace 'install
	   (lambda* (#:key outputs #:allow-other-keys)
	     (install-file "cfitsio.pc" (string-append (assoc-ref outputs "out")
							 "/lib/pkgconfig/"))
	     (symlink "libcfitsio.so" (string-append (assoc-ref outputs "out")
						     "/lib/libcfitsio.so.5"))
	     (let ((include (string-append (assoc-ref outputs "out") "/include/"))
		   (bin (string-append (assoc-ref outputs "out") "/bin/"))
		   (lib (string-append (assoc-ref outputs "out") "/lib/")))
	       (for-each (lambda (file)
			   (install-file file lib))
			 '("libcfitsio.a" "libcfitsio.so.5"))
	       (for-each (lambda (file)
			   (install-file file include))
			 '("drvrsmem.h" "fitsio2.h" "fitsio.h" "longnam.h"))
	       (for-each (lambda (file)
			   (install-file file bin))
			 '("fpack" "funpack" "fitscopy"))
	       #t))))))
   (home-page "https://heasarc.gsfc.nasa.gov/fitsio/")
   (synopsis "reading and writing data files in FITS (Flexible Image Transport System) data format.")
   (description "CFITSIO is a library of C and Fortran subroutines for reading
and writing data files in FITS (Flexible Image Transport System) data format.
CFITSIO provides simple high-level routines for reading and writing FITS files
that insulate the programmer from the internal complexities of the FITS format.")
   (license #f)))

; should check if this is AVX sw gather-scattter from 2012 openlab,
; looping accross object geometrys and making a bit-map for asm jmp.
; learned a lot when the cream of performance tuning from intel and google
; showed up at cern a few months later at the very least.
(define-public vdt
  (package
  (name "vdt")
  (version "0.3.7")
  (source (origin
    (method git-fetch)
    (uri (git-reference
           (url "https://github.com/dpiparo/vdt")
	   (commit "v0.3.7")))
    (sha256
      (base32
        "145hcnwyjyir9j7c3d6fz74wx9655hh068ianlzw0cg4sj0g9dfy"))))
   (build-system cmake-build-system)
   (inputs
     `(("python", python-2)))
   (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
	 (replace 'configure
           (lambda _ (and (zero? (system* "cmake" (string-append "-DCMAKE_INSTALL_PREFIX="
								 (assoc-ref %outputs "out"))
					  "-DAVX=OFF" "-DAVX2=OFF" "-DFMA=OFF"
					  "-DDEBUG=OFF" "-DDIAG=OFF" "."))))))))
   (home-page "https://github.com/dpiparo/vdt")
   (synopsis "vectorised math library for geant4")
   (description "Born and developed at CERN, it is used, among
the others, by LHC experiments and the Geant4 simulation toolkit.")
   (license license:lgpl3+)))


; doesn't work, no source and tarball is shell scripts for downloading.
;(define-public dcache
;  (package
;  (name "dcache")
;  (version "2.13.31")
;  (source (origin
;    (method url-fetch)
;    (uri (string-append "http://dcache""-""desy22.desy.de"":""22222/pnfs/desy.de/desy/dcache.org/2.13/"
;			"dcache-" version ".tar.gz"))
;    (sha256
;      (base32
;        "19sra59qi10m2dghzgnmx2mqr9f6k35kyzw3a3lcpnwk3j1lbq2n"))))
;   (build-system cmake-build-system)
;   (arguments
;     `(#:tests? #f))
;   (home-page "")
;   (synopsis "")
;   (description "")
;   (license license:gpl2)))


(define-public geant3
  (package
  (name "geant3")
  (version "2.1")
  (source (origin
    (method git-fetch)
    (uri (git-reference
           (url "http://root.cern.ch/git/geant3.git")
	   (commit "v2-1")))
    (sha256
      (base32
        "1j8fszy9jp8ml98v8wlibl178kdlv6c9z71n817xwgml9fz03cvp"))))
   (build-system cmake-build-system)
   (inputs
     `(("root", root)
       ("gfortran", gfortran)))
   (arguments
     `(#:tests? #f
       #:configure-flags '("-DGeant3_INSTALL_DATA=OFF")))
   (home-page "http://geant.cern.ch/")
   (synopsis "Geometry And Tracking")
   (description "geant3 is written in fortran")
   (license license:gpl2)))

; should perhaps be replaced, very old and poorely maintained
; consider extracting from afterstep wm tarball
; this library is likely a security problem, disable some optimizations
; and warning, -Wunused-but-set-variable breaks the build
(define-public libafterimage
  (package
  (name "libafterimage")
  (version "1.20")
  (source (origin
    (method url-fetch)
    (uri (string-append "ftp://ftp.afterstep.org/stable/libAfterImage/"
			"libAfterImage-" version ".tar.gz"))
    (sha256
      (base32
        "125y119fbr3g389nr7yls4i7x5zd5pz7h8qn12k8b21b4xk1h6y5"))))
   (build-system gnu-build-system)
   (inputs
      `(("pkg-config", pkg-config)
       ("freetype", freetype)))
   (propagated-inputs
     `(("libxpm", libxpm)
       ("libjpeg", libjpeg)
       ("libtiff", libtiff)
       ("librsvg", librsvg)))
   (arguments
     `(#:tests? #f
       #:make-flags (list "CCFLAGS=-O0 -fPIC -Wall -fno-aggressive-loop-optimizations -Wno-unused-but-set-variable")
       #:configure-flags '("--with-tiff" "--with-xpm" 
			   "--with-ttf" "--with-svg"
			   "--without-png" )))
   (home-page "http://www.afterstep.org/afterimage/index.php")
   (synopsis "libAfterImage is a generic image manipulation library")
   (description "It was initially implemented to address AfterStep
Window Manager's needs for image handling")
   (license #f)))


; does not build due to the crazy symlink/cmake-git versioning scheme.
; rather fix the build process than hack around it!
; RelWithDebInfo doesn't work
(define-public aliroot
  (package
  (name "aliroot")
  (version "v5-08-11a")
  (source (origin
    (method git-fetch)
    (uri (git-reference
           (url "http://git.cern.ch/pub/AliRoot")
	   (commit "v5-08-11a")))
    (sha256
      (base32
        "0m2h80la5mw85x8kx9xfshn3d3ngnlk8556yrvkpl6gxhqalkyhs"))))
   (build-system cmake-build-system)
   (inputs
     `(("geant4_vmc", geant4_vmc)
	("root", root)
	("geant3", geant3)
	("doxygen", doxygen)
	("zeromq", zeromq)))	
   (arguments
     `(#:tests? #f
       #:build-type "RELWITHDEBINFO"))
   (home-page "http://aliweb.cern.ch/Offline/AliRoot/Manual.html")
   (synopsis "AliRoot for the ALICE collaboration at CERN")
   (description "Analysis framework for HEP")
   (license #f)))

; dont use in ALICE! why was this in alidist???
; note, dont trust alidist on github!!!
; also using the wrong cteq pdfsets 1 and 11, rahter than l and ll.
; when is Heavy-Ion software moving to c++
; intel Cilk array  notation available since gcc 4.9
; https://www.cilkplus.org/

;(define-public lhapdf
;  (package
;  (name "lhapdf")
;  (version "6.1.6")
;  (source (origin
;    (method url-fetch)
;    (uri (string-append "http://www.hepforge.org/archive/lhapdf/"
;			"LHAPDF-" version ".tar.gz"))
;    (sha256
;      (base32
;        "1sgbaxv8clcfy4d96fkwfyqcd4b29i0hwv32ry4vy69j5qiki0f2"))))
;   (build-system gnu-build-system)
;   (inputs
;     `(("boost", boost)
;       ("python", python-2)
;       ("libtool", libtool)
;       ("cteq61"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1.6/cteq6.tar.gz")
;	   (sha256
;	     (base32
;	       "0wk6fmajvbdh8wmx1wmyd9n53m82vvh2gj4iric4b4ig9ssmbjx9")))) 
;       ("cteq611"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1.6/cteq6l1.tar.gz")
;	   (file-name "cteq611.tar.gz")
;	   (sha256
;	     (base32
;	       "1b5m7g7wawk72h76l9yr3gx3n67jggna1004lwffvj43gffwkjap"))))
;       ("ct10"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1.6/CT10.tar.gz")
;	   (sha256
;	     (base32
;	       "17glhnqj4yknqy70zs7m097n1qq9fqljj3mna6qxchmgql04dvxw"))))
;       ("ct10nlo"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1/CT10nlo.tar.gz")
;	   (sha256
;	     (base32
;	       "14ib003sxpxc8awywjckbw124aqhmi70wg4hlwc2nvdh46sqk11b"))))
;       ("mstw2008nnlo68cl"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1.6/MSTW2008nnlo68cl.tar.gz")
;	   (sha256
;	     (base32
;	       "0y6lv1wkhydfnlakjrrrjapxaapa0bcbmfx0w9c4psgy156kv1fv"))))
;       ("mstw2008nnlo90cl"
;	,(origin
;	   (method url-fetch)
;	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/6.1.6/MSTW2008nnlo90cl.tar.gz")
;	   (sha256
;	     (base32
;	       "13xqlfys37b8chinah2yqmzd0clzli06p7vjk30ha22wgwm02dq3"))))
;    ))
;   (arguments
;     '(#:tests? #f
;       #:make-flags (list (string-append "LDFLAGS=-Wl,-rpath="
;					 (assoc-ref %outputs "out") "/lib"))
;       #:phases
;        (modify-phases %standard-phases
;          (add-after 'install 'install-pdfsets
;            (lambda* (#:key inputs outputs #:allow-other-keys)
;                (begin
;                  (mkdir-p (string-append (assoc-ref outputs "out") "/share/LHAPDF"))
;                  (chdir (assoc-ref outputs "out"))
;                   (with-directory-excursion (string-append "share/LHAPDF")
;                         (copy-file (assoc-ref inputs "cteq61") "cte61.tar.gz")
;                         (copy-file (assoc-ref inputs "cteq611") "cteq611.tar.gz")
;                         (copy-file (assoc-ref inputs "ct10") "ct10.tar.gz")
;                         (copy-file (assoc-ref inputs "ct10nlo") "ct10nlo.tar.gz")
;                         (copy-file (assoc-ref inputs "mstw2008nnlo68cl") "mstwnnlo68cl.tar.gz")
;                         (copy-file (assoc-ref inputs "mstw2008nnlo90cl") "mstwnnlo90cl.tar.gz")
;                         (zero? (system* "tar" "xvf" "cteq61.tar.gz"))
;                         (zero? (system* "tar" "xvf" "cteq611.tar.gz"))
;                         (zero? (system* "tar" "xvf" "ct10.tar.gz"))
;                         (zero? (system* "tar" "xvf" "ct10nlo.tar.gz"))
;                         (zero? (system* "tar" "xvf" "mstwnnlo68cl.tar.gz"))
;                         (zero? (system* "tar" "xvf" "mstwnnlo90cl.tar.gz"))
;                         (for-each delete-file (find-files "." "\\.tar.gz")))))))))
;
;   (home-page "http://lhapdf.hepforge.org/")
;   (synopsis "C++ used for evaluating PDFs from discretised data files")
;   (description "LHAPDF is a general purpose C++ interpolator, used for
;evaluating PDFs from discretised data files. ")
;   (license license:gpl3)))

; pdfsets, sure none are missing? alisw is inconsistent!?
; PDFSETS="cteq6l cteq6ll CT10 CT10nlo MSTW2008nnlo EPS09LOR_208"
;  https://github.com/alisw/alidist/blob/IB/v5-08/prod/lhapdf5.sh
; https://github.com/alisw/alidist/blob/IB/v5-08/o2/lhapdf5.sh
; PDFSETS="cteq6l cteq6ll CT10 CT10nlo MSTW2008nnlo EPS09LOR_208 EPS09NLOR_208"
; https://github.com/alisw/alidist/blob/IB/v5-08/o2/lhapdf5.sh /prod missing NLOR
; PDFSETS="cteq6l cteq6ll EPS09LOR_208"
; https://github.com/alisw/alidist/blob/IB/v5-06/prod/lhapdf5.sh jan 12
; https://github.com/alisw/alidist/blob/IB/v5-06/next/lhapdf5.sh
; Also, EPS09 pdfsets not available for lhapdf 6.x!
; for lhapdf-6.1.6 its cteql1 rather than 11? while in 5.9.1 there
; is no 11, but there is a cteq6ll.LHpdf -- makes no sense, this matter.
; In fact, lhapdf-6.15 doesnt seem to have any of the cteq pdfsets used by alice.
; only master branch using root6 and v5-08/o2 has the full set:
; PDFSETS="cteq6l cteq6ll CT10 CT10nlo MSTW2008nnlo EPS09LOR_208 EPS09NLOR_208"


(define-public lhapdf5
  (package
  (name "lhapdf5")
  (version "5.9.1")
  (source (origin
    (method url-fetch)
    (uri (string-append "https://www.hepforge.org/archive/lhapdf/"
                        "lhapdf-" version ".tar.gz"))
    (sha256
      (base32
        "174ihr8cz02h4acdw65f9cprfd2m3kplfs5b5b72fmpjsx3b1fc6"))))
   (build-system gnu-build-system)
   (inputs
     `(("boost", boost)
       ("gfortran", gfortran)
       ("python", python-2)
       ("libtool", libtool)
       ("cteq6l.pdf"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/cteq6l.LHpdf")
           (sha256
             (base32
               "0q9kil74n997nggqyic83xds89lnc594rmvd2xdbli33gqsx475z"))))
       ("cteq6ll.pdf"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/cteq6ll.LHpdf")
           (sha256
             (base32
               "00sw5ff65wx0fcgvcrclwmk2m1w1l8mr557s4gx7a3x3pqgbvim3"))))

       ("ct10.grid"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/CT10.LHgrid")
           (sha256
             (base32
               "101b5mas8g0jgrxd69xfmhpda66wwyn1kwjk24pkzfgvnckpglgd"))))

       ("ct10nlo.grid"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/CT10nlo.LHgrid")
           (sha256
             (base32
               "087ija31wi9dzhr77a44a88i4ql3cbf36q8npxg4yk1kxqmrsvyz"))))
       ("mstw2008nnlo68cl.grid"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/MSTW2008nnlo68cl.LHgrid")
           (sha256
             (base32
               "11205w2njr0aicv8bkhyjvlhrqy0yh41hqijr0mp7six79ln0p08"))))
       ("mstw2008nnlo90cl.grid"
        ,(origin
           (method url-fetch)
           (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/MSTW2008nnlo90cl.LHgrid")
           (sha256
             (base32
               "051pw4qsvy559rc0p9mb6qdp8khymal6pfrd6vcxzv6cymsn6wkp"))))
       ("eps09lor_208.grid"
	,(origin
	   (method url-fetch)
	   (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/EPS09LOR_208.LHgrid")
	   (sha256
	     (base32
	       "14v15cmqjmwx0ln8s5g7xk8l3mqh38hh6svi4f1wkcb79l4frjbz"))))
       ("eps09nlor_208.grid"
       ,(origin
	  (method url-fetch)
	  (uri "https://www.hepforge.org/archive/lhapdf/pdfsets/5.9.1/EPS09NLOR_208.LHgrid")
	  (sha256
	    (base32
	      "0sylmmf7f0c6hwaznkihi66xanm2v8h30pxdwvd7nw56766x54p4"))))
    ))
   (arguments
     '(#:tests? #f
       #:make-flags (list (string-append "LDFLAGS=-Wl,-rpath="
                                         (assoc-ref %outputs "out") "/lib"))
       #:phases
        (modify-phases %standard-phases
          (add-after 'install 'install-pdfsets
            (lambda* (#:key inputs outputs #:allow-other-keys)
                  (chdir (assoc-ref outputs "out"))
                   (with-directory-excursion (string-append "share/lhapdf")
                         (copy-file (assoc-ref inputs "cteq6l.pdf") "cteq6l.LHpdf")
                         (copy-file (assoc-ref inputs "cteq6ll.pdf") "cteq6ll.LHpdf")
                         (copy-file (assoc-ref inputs "ct10.grid") "CT10.LHgrid")
                         (copy-file (assoc-ref inputs "ct10nlo.grid") "CT10nlo.LHgrid")
                         (copy-file (assoc-ref inputs "mstw2008nnlo68cl.grid") "MSTW2008nnlo68cl.LHgrid")
                         (copy-file (assoc-ref inputs "mstw2008nnlo90cl.grid") "MSTW2008nnlo90cl.LHgrid")
                         (copy-file (assoc-ref inputs "eps09lor_208.grid") "EPS09LOR_208.LHgrid")
                         (copy-file (assoc-ref inputs "eps09nlor_208.grid") "EPS09NLOR_208.LHgrid")))))))

   (home-page "http://lhapdf.hepforge.org/lhapdf5")
   (synopsis "C++ used for evaluating PDFs from discretised data files")
   (description "lhapdf5 is a general purpose interpolator, used for
evaluating PDFs from discretised data files. ")
   (license license:gpl2)))

(define-public jewel
  (package
  (name "jewel")
  (version "2.0.2")
  (source (origin
    (method url-fetch)
    (uri (string-append "https://www.hepforge.org/archive/jewel/"
			"jewel-" version ".tar.gz"))
    (sha256
      (base32
        "0yrxigp673x1gm20jlacmcgfn6ngjba965a16rlifimwj7l1p80k"))))
   (build-system gnu-build-system)
   (inputs
     `(("lhapdf5", lhapdf5)
       ("gfortran", gfortran)))
   (arguments
     `(#:tests? #f
       #:make-flags (list (string-append "LHAPDF_PATH="
					 (assoc-ref %build-inputs "lhapdf5")
					 "/share/lhapdf")
			  "FFLAGS=-g -static")
       #:phases
       (modify-phases %standard-phases
	       (delete 'configure)
	       (replace 'install
			(lambda* (#:key outputs #:allow-other-keys)
			  (install-file (string-append "jewel-" ,version "-simple")
					(string-append (assoc-ref outputs "out")
						       "/bin/"))
		          (install-file (string-append "jewel-" ,version "-vac")
					(string-append (assoc-ref outputs "out")
						       "/bin/"))
			  #t))
	       (replace 'unpack
			(lambda* (#:key source #:allow-other-keys)
				 (and (mkdir "jewel"))
				 (zero? (system* "tar" "xvf" source "-C" "jewel"))
				 (chdir "jewel"))))))
   (home-page "https://www.hepforge.org/")
   (synopsis "JEWEL is a MC event generator simulating QCD jet evolution in heavy-ion collisions")
   (description "JEWEL is a Monte Carlo event generator simulating
QCD jet evolution in heavy-ion collisions. It treats the interplay
of QCD radiation and re-scattering in a medium with fully microscopic
dynamics in a consistent perturbative framework with minimal assumptions. ")
   (license license:gpl2)))


