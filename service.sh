#!/system/bin/sh
# Made By ANDROID2468
# This is to fix voice/SMS service at startup on some of the VS986 models
sleep 10
#sees if your device is a VS986
dev="$(getprop ro.product.model)"
if [ "${dev}" = "LGVS986" ];
then
    # sees if you got cell service
    net="$(getprop |grep gsm.network.type)"
    while [ "${net}" = "[gsm.network.type]: [Unknown]" ]
    do
        sleep 10
        net="$(getprop |grep gsm.network.type)"
    done

    sleep 10
    net="$(getprop |grep gsm.network.type)"
    while [ "${net}" = "[gsm.network.type]: [Unknown]" ]
    do
        sleep 5
        net="$(getprop |grep gsm.network.type)"
    done

    sim="$(getprop |grep sim.operator.alpha)"
    # this checks if you have a verizon sim
    if [ "${sim}" = "[gsm.sim.operator.alpha]: [Verizon]" ];
    then
        sleep 10
        # this tests your phone has made an conection 
        gsmOp="$(getprop |grep gsm.operator.alpha)"
        if [ "${gsmOp}" = "[gsm.operator.alpha]: []" ];
        then
            # This calls the testcall.com phone number 
            service call audio 7 i32 0 i32 0 i32 8    
            am start -a android.intent.action.CALL -d tel:"804-222-1111"
            sleep 20
            service call audio 7 i32 0 i32 7 i32 8 
        fi
    fi
fi
