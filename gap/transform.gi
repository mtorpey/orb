#############################################################################
##
##                             orb package
##  transform.gi
##                                                        by Juergen Mueller
##                                                       and Max Neunhoeffer
##                                                          and Felix Noeske
##
##  Copyright 2005-2010 by the authors.
##  This file is free software, see license information at the end.
##
##  Optimisations for transformations.
##
#############################################################################

# Install our C function if we are compiled:
if IsBound( MappingPermListList_C ) then
    MakeReadWriteGVar("MappingPermListList");
    MappingPermListList := MappingPermListList_C;
    MakeReadOnlyGVar("MappingPermListList");
fi;

if IsBound( MappingPermSetSet_C ) then
    InstallGlobalFunction( MappingPermSetSet, MappingPermSetSet_C );
else
    InstallGlobalFunction( MappingPermSetSet,
      function(src, dst)
        local l, d, out, i, j, next, k;
        l:=Length(src);
        if l <> Length(dst) then
            Error("both arguments must be lists of the same length");
            return;
        fi;
        d:=Maximum(src[l], dst[l]);
        out:=EmptyPlist(d);

        i:=1;
        j:=1;
        next:=1;   # the next candidate, possibly prevented from being in dst

        for k in [1..d] do
          if i<=l and k=src[i] then
            out[k]:=dst[i];
            i:=i+1;
          else
            # Skip things in dst:
            while j<=l and next>=dst[j] do
              if next = dst[j] then next:=next+1; fi;
              j:=j+1;
            od;
            out[k]:=next;
            next:=next+1;
          fi;
        od;

        return PermList(out);
      end ); 
fi;

##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##
