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

(define-module (broken-packages powdertoy)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system scons)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages compression)
  ;; #:use-module (gnu packages gl)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages python-xyz))

(define-public powdertoy
  (package
   (name "powdertoy")
   (version "94.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://github.com/The-Powder-Toy/The-Powder-Toy.git")
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1yblf911hmda3nndd1ap4iv9fqaryjavqzf0lzzxqk158zqqnagw"))))
   (build-system scons-build-system)
   (arguments
    `(#:tests? #f
      ;;      #:scons ,scons-python2)
      #:scons-flags (list (string-append "DESTDIR=" %output))
      #:phases (modify-phases %standard-phases
		     ;; (delete 'install))
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin"))
		    (icon-dir (string-append out "/share/pixmaps")))
               (with-directory-excursion "build"
		 (if (file-exists? "powder64")
                     (rename-file "powder64" "powdertoy")
                     (rename-file "powder" "powdertoy"))
                 (install-file "powdertoy" bin))
	       (with-directory-excursion "resources"
		 (rename-file "icon/powder-256.png" "powder.png")
		 (install-file "powder.png" icon-dir))
               #t))))
          ;; (add-after 'install 'install-powdertoy-desktop
           ;; (lambda* (#:key outputs #:allow-other-keys)
             ;; (let* ((out (assoc-ref outputs "out"))
                    ;; (desktop (string-append out "/share/applications"))
                    ;; (icon-dir (string-append out "/share/pixmaps")))
               ;; (rename-file "icon.png" "godot.png")
               ;; (install-file "godot.png" icon-dir)
               ;; (mkdir-p desktop)
               ;; (with-output-to-file
                   ;; (string-append desktop "/powdertoy.desktop")
                 ;; (lambda _
                   ;; (format #t
                           ;; "[Desktop Entry]~@
                           ;; Name=PowderToy~@
                           ;; Comment=The Powder Toy~@
                           ;; Exec=~a/bin/powder~@
                           ;; TryExec=~@*~a/bin/powder~@
                           ;; Icon=powder~@
                           ;; Type=Application~%"
                           ;; out)))
               ;; #t))))))
	       
	   ))
	     
   (inputs
    `(("fftwf" ,fftwf)
      ("lua" ,lua-5.1)
      ;; ("glew" ,glew)
      ("pkg-config" ,pkg-config)
      ("sdl2" ,sdl2)
      ("zlib" ,zlib)))
   (home-page "https://powdertoy.co.uk/")
   (synopsis "Falling sand physics simulator sandbox")
   (description "Written in C++ and using SDL, The Powder Toy is a desktop version of the classic 'falling sand' physics sandbox.  It simulates air pressure and velocity as well as heat.

Have you ever wanted to blow something up?  Or maybe you always dreamt of operating an atomic power plant?  Do you have a will to develop your own CPU?  The Powder Toy lets you to do all of these, and even more!

The Powder Toy is a free physics sandbox game, which simulates air pressure and velocity, heat, gravity and a countless number of interactions between different substances!  The game provides you with various building materials, liquids, gases and electronic components which can be used to construct complex machines, guns, bombs, realistic terrains and almost anything else.  You can then mine them and watch cool explosions, add intricate wirings, play with little stickmen or operate your machine.  You can browse and play thousands of different saves made by the community or upload your own – we welcome your creations!

There is a Lua API – you can automate your work or even make plugins for the game.  The Powder Toy is free and the source code is distributed under the GNU General Public License, so you can modify the game yourself or help with development.  TPT is compiled using scons.")
   (license license:gpl3+)))
