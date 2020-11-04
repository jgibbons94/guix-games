;;; Broken Guix
;;; Guix packages that are in-progress, broken, nonfree, or otherwise will
;;; not build and run to my satisfaction.
;;;
;;; Copyright (C) 2019 Jesse Gibbons
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
(define-module (broken-packages pysolfc)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix licenses)
  #:use-module (guix gexp)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages base)
  #:use-module (gnu packages perl)
  )

(define-public pysolfc
  (package
   (name "pysolfc")
   (version "2.6.4")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
	   "https://github.com/shlomif/PySolFC/archive/pysolfc-"
	   version
	   ".tar.gz"))
     (sha256
      (base32
       "17r9mbn4fj6kbxhllsab74gfjac0j2mjdwkkwaxp6cqpy4dss3z8"))))
   (build-system python-build-system)
   (native-inputs
     `(("make" ,gnu-make)
       ("perl" ,perl)
       ("python2" ,python-2)
       ("moose" ,perl-moose)
       ("coreutils" ,coreutils)
       ("python2-pycotap" ,python2-pycotap)
       ))
    (propagated-inputs
     `(
       ("python2-six"  ,python2-six)
       ("python2-tkinter" ,python-2 "tk")
       ("python2-random2" ,python2-random2)
       ("python2" ,python-2)
       ("python-six"  ,python-six)
       ("python-tkinter" ,python "tk")
       ("python-random2" ,python-random2)))
   (arguments
    `(#:python ,python
      #:phases (modify-phases %standard-phases
			      ;; (add-before 'patch-generated-file-shebangs 'generate-tests
			      ;; 		 (lambda _
			      ;; 		   (begin
			      ;; 		     (invoke "make" "pretest")
			      ;; 		     (system "echo =================")
			      ;; 		     (invoke "echo" (string-append "#!" (which "env")))
			      ;; 		     (substitute* (find-files "tests" "\\.py$")
			      ;; 				  (("#!/usr/bin/env")
			      ;; 				   (string-append "#!" (which "env"))))
			      ;; 		     )))
			      ;; (add-before 'build 'make-test
			      ;; 		 (lambda _
			      ;; 		   (begin
			      ;; 		     (system "cat tests/unit-generated/*")
			      ;; 		     (invoke "false")
			      ;; 		     (invoke "make" "test")
			      ;; 		     )))
			      (add-before 'build 'make-rules
					  (lambda _
					    (begin
					      (invoke "make" "rules"))))
			      (add-after 'make-rules 'move-images
					 (lambda _
					   (begin
					     (invoke "false")
					     #t
					     ))))))
   
   (home-page "https://pysolfc.sourceforge.io/")
   (synopsis
    "Solitaire Collection, Written in Python")
   (description
    "PySol Fan Club Edition (PySolFC) is a collection of more than 1000 solitaire card games. It is a fork of PySol Solitaire.")
   (license gpl3+)))

(define python-random2
  (package
   (name "python-random2")
   (version "1.0.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "random2" version ".zip"))
     (sha256
      (base32
       "01y0s4747plsx8fdnxy0nz83dp69naddz58m81r9h0s1qfm31b9l"))))
   (native-inputs
    `(("unzip" ,unzip)))
   (build-system python-build-system)
   (arguments
    `(#:python ,python
      #:use-setuptools? #f))
   (home-page "http://pypi.python.org/pypi/random2")
   (synopsis
    "Python 3 compatible Pytohn 2 `random` Module.")
   (description
    "Python 3 compatible Pytohn 2 `random` Module.")
   (license #f)))

(define python2-random2
  (package
   (name "python2-random2")
   (version "1.0.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "random2" version ".zip"))
     (sha256
      (base32
       "01y0s4747plsx8fdnxy0nz83dp69naddz58m81r9h0s1qfm31b9l"))))
   (native-inputs
    `(("unzip" ,unzip)))
   (build-system python-build-system)
   (arguments
    `(#:python ,python-2
      #:use-setuptools? #f))
   (home-page "http://pypi.python.org/pypi/random2")
   (synopsis
    "Python 3 compatible Pytohn 2 `random` Module.")
   (description
    "Python 3 compatible Pytohn 2 `random` Module.")
   (license #f)))

(define-public python-pycotap
  (package
   (name "python-pycotap")
   (version "1.1.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pycotap" version))
     (sha256
      (base32
       "128qn7zjn95nivcxbxjclkwjw2qif5sf9c1b8rrsczcpn78kckf1"))))
   (inputs `(("python" ,python)))
   (build-system python-build-system)
   (arguments
    `(#:python ,python))
   (home-page "https://el-tramo.be/pycotap")
   (synopsis
    "A tiny test runner that outputs TAP results to standard output.")
   (description
    "A tiny test runner that outputs TAP results to standard output.")
   (license expat)))

(define-public python2-pycotap
  (package
   (name "python2-pycotap")
   (version "1.1.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pycotap" version))
     (sha256
      (base32
       "128qn7zjn95nivcxbxjclkwjw2qif5sf9c1b8rrsczcpn78kckf1"))))
   (build-system python-build-system)
   (arguments
    `(#:python ,python-2))
   (home-page "https://el-tramo.be/pycotap")
   (synopsis
    "A tiny test runner that outputs TAP results to standard output.")
   (description
    "A tiny test runner that outputs TAP results to standard output.")
   (license expat)))
