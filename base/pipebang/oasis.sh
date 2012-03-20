#!/usr/bin/env bash
set -e -u -o pipefail

source ../../build-common.sh

cat >$HERE/_oasis <<EOF
#AUTOGENERATED FILE; EDIT oasis.sh INSTEAD
OASISFormat:  0.2
OCamlVersion: >= 3.12
Name:         pipebang
Version:      0.1.1
Synopsis:     Syntax extension to transform x |! f into f x
Authors:      Jane street capital
Copyrights:   (C) 2009-2011 Jane Street Capital LLC
License:      LGPL-2.1 with OCaml linking exception
LicenseFile:  LICENSE
Plugins:      StdFiles (0.2),
              DevFiles (0.2),
              META (0.2)
XStdFilesREADME: false
XStdFilesAUTHORS: false
XStdFilesINSTALLFilename: INSTALL
BuildTools:   ocamlbuild, camlp4o

Library pa_pipebang
  Path:               lib
  Modules:            Pa_pipebang
  FindlibName:        pa_pipebang
  BuildDepends:       camlp4.lib,
                      camlp4.quotations,
                      type_conv (>= 3.0.5)
  CompiledObject:     byte
  XMETAType:          syntax
  XMETARequires:      camlp4,type_conv,oUnit
  XMETADescription:   Syntax extension writing inline tests
EOF

make_tags $HERE/_tags <<EOF
<lib/pa_pipebang.ml>: syntax_camlp4o,pkg_camlp4.extend
EOF

cd $HERE
oasis setup
./configure "$@"

