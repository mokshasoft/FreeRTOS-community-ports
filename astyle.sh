#/bin/sh

#
# Script that formats each port with astyle
#

SRC_DEMOS=$(find Demo/ -name '*.[ch]' | grep -v "^Demo/Common")
SRC_PORTS=$(find Source/portable/ -name '*.[ch]' | grep -v "^Source/portable/MemMang")

astyle \
    --max-instatement-indent=100 \
    --style=otbs \
    --pad-header \
    --indent=spaces=4 \
    --pad-oper \
    --unpad-paren \
    ${SRC_DEMOS} \
    ${SRC_PORTS}
