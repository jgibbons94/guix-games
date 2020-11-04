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

(define-module (broken-packages tuxemon)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages game-development)
  #:use-module (gnu packages python)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-web))

(define-public tuxemon
  (let
      ((url "https://github.com/jgibbons94/Tuxemon.git")
       (commit "build-translations-on-install"))
  (package
   (name "tuxemon")
   (version "0.4.0-alpha-0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url url)
	   (commit commit)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1x3xzqcafmlakwq0fh461a6h8xd6xi528k7i8a3vln2fai9qxr74"))))
   (build-system python-build-system)
   (arguments
    `(#:python ,python-2
      #:tests? #f
      #:use-setuptools? #t
      #:phases
      (modify-phases %standard-phases
		     (add-after 'unpack 'set-home-directory
				;; FATAL: Cannot create run dir '/homeless-shelter/.run' - errno=2   
				(lambda _ (setenv "HOME" "/tmp") #t))
      (add-after 'build 'build-translations
		 (lambda _ #t)))))
   (propagated-inputs
    `(("python-pygame" ,python2-pygame)
      ("python-pytmx" ,python2-pytmx)
      ("python-six" ,python2-six)
      ("python-pyscroll" ,python2-pyscroll)
      ("python-neteria" ,python2-neteria)
      ("python-pillow" ,python2-pillow)
      ("python-babel" ,python2-babel)
      ("python-requests" ,python2-requests)
      ("python-lxml" ,python2-lxml)
      ("python-nose" ,python2-nose)
      ("python-mock" ,python2-mock)
      ("python-cbor" ,python2-cbor)))
   ;;optional: libshake
   (home-page "https://github.com/Tuxemon/Tuxemon")
   (synopsis "Monster-fighting RPG")
   (description "Tuxemon is a monster-fighting role-playing game.
Though it looks like pokemon, it contains all original code.")
   (license license:gpl3+))))

(define-public python-pytmx
  (package
   (name "python-pytmx")
   (version "3.21.7")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "PyTMX" version))
     (sha256
      (base32
       "19wgjdhkzzi2kpnba6xpr29b24dqy3nhdvcfardfm738mzxc3sgn"))))
   (build-system python-build-system)
   (propagated-inputs `(("python-six" ,python-six)))
   (home-page "")
   (synopsis
    "loads tiled tmx maps.  for python 2.7 and 3.3+")
   (description
    "loads tiled tmx maps.  for python 2.7 and 3.3+")
   (license #f)))

(define-public python2-pytmx
  (package-with-python2 python-pytmx))

(define-public python-pyscroll
  (package
   (name "python-pyscroll")
   (version "2.19.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pyscroll" version))
     (sha256
      (base32
       "175d39rymnx3v3mcfjjkr1wv76nsl1s00z04nzsspklyk0ih2783"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-pygame" ,python-pygame)))
   (home-page "http://github.com/bitcraft/pyscroll")
   (synopsis
    "Fast scrolling maps library for pygame and python 2.7 & 3.3+")
   (description
    "Fast scrolling maps library for pygame and python 2.7 & 3.3+")
   (license #f)))

(define-public python2-pyscroll
  (package-with-python2 python-pyscroll))


(define-public python-neteria
  (package
   (name "python-neteria")
   (version "1.0.3.160123.05")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/ShadowBlip/Neteria.git")
	   (commit "1a8c976eb2beeca0a5a272a34ac58b2c114495a4")));no tags
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1c2fa0d4k2n3b88ac8awajqnfbar2y77zhsxa3wg0hix8lgkmgz3"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-rsa" ,python2-rsa)))
   (home-page "https://github.com/Tuxemon/Tuxemon")
   (synopsis "Game networking library for Python")
   (description "Neteria is a library for python game servers and clients.")
   (license license:gpl3+)))

(define-public python2-neteria
  (package-with-python2 python-neteria))

(define-public python-cbor
  (package
   (name "python-cbor")
   (version "1.0.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "cbor" version))
     (sha256
      (base32
       "1dmv163cnslyqccrybkxn0c9s1jk1mmafmgxv75iamnz5lk5l8hk"))))
   (build-system python-build-system)
   (home-page
    "https://bitbucket.org/bodhisnarkva/cbor")
   (synopsis
    "RFC 7049 - Concise Binary Object Representation")
   (description
    "RFC 7049 - Concise Binary Object Representation")
   (license #f)))

(define-public python2-cbor
  (package-with-python2 python-cbor))
