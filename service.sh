#!/system/bin/sh
# Made By ANDROID2468
# This is to fix voice/SMS service at startup on some of the VS986 models
sleep 20
#sees if your device is a VS986
dev="$(getprop ro.product.model)"
if [ "${dev}" = "LGVS986" ];
then
    # sees if you got cell service
    iso="$(getprop |grep gsm.operator.iso)"
    while [ "${iso}" = "[gsm.operator.iso-country]: []" ]
    do
        sleep 5
        iso="$(getprop |grep gsm.operator.iso)"
    done
    sim="$(getprop |grep sim.operator.alpha)"
    # this checks if you have a verizon sim
    if [ "${sim}" = "[gsm.sim.operator.alpha]: [Verizon]" ];
    then
        sleep 5
        # this tests your phone has made an conection 
        gsmOp="$(getprop |grep gsm.operator.alpha)"
        if [ "${gsmOp}" = "[gsm.operator.alpha]: []" ];
        then
            # This calls the testcall.com phone number 
            am start -a android.intent.action.CALL -d tel:"804-222-1111"
        fi
    fi
fi
