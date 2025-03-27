#!/vendor/bin/sh

model=$(grep -aim1 'model:' /dev/block/by-name/LTALabel | sed -e 's/^.*model:[ ]*\([A-Za-z0-9-]*\).*$/\1/I') 2> /dev/null

# Desperate measures
if [ "$model" == "" ]; then
    model=$(strings /dev/block/by-name/LTALabel | grep -m 1 -oE '(SO-01M|SOV41|901SO|SO-03L|SOV40|802SO)') 2> /dev/null
fi

case "$model" in
    "J9110" | "J9150" | "J9180" | "J9210" | "J9260")
        setprop vendor.radio.hardware.sku ds;;
    * )
        setprop vendor.radio.hardware.sku ss;;
esac

if [ "$model" == "" ]; then
    setprop vendor.radio.ltalabel.model "unknown"
else
    setprop vendor.radio.ltalabel.model "$model"
fi
