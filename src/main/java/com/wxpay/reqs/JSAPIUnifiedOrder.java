package com.wxpay.reqs;

import java.util.Properties;

import com.wxpay.constants.*;

public class JSAPIUnifiedOrder extends UnifiedOrder
{
  // COSTRUCT
    public JSAPIUnifiedOrder(Properties prop)
    {
        super(prop);

        this.setTradeType(TradeType.JSAPI);

        return;
    }
}
