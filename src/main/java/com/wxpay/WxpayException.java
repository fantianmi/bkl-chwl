package com.wxpay;

import com.wxpay.constants.WxpayErrorCode;

public class WxpayException extends RuntimeException
{
  // FIELDS
    private WxpayErrorCode errorCode;

  // CONSTRUCT
    public WxpayException()
    {
        return;
    }

    public WxpayException(Throwable cause)
    {
        this.initCause(cause);

        return;
    }

    public WxpayException(WxpayErrorCode aErrorCode, Throwable cause)
    {
        this.errorCode = aErrorCode;
        this.initCause(cause);

        return;
    }

    public WxpayException(WxpayErrorCode aErrorCode)
    {
        this(aErrorCode, null);
    }

    public WxpayException(String aErrorName)
    {
        this(
            WxpayErrorCode.forName(aErrorName),
            null
        );
    }

    public WxpayException(String aErrorName, Throwable cause)
    {
        this(
            WxpayErrorCode.forName(aErrorName),
            cause
        );
    }

    public WxpayException(int aErrorCode)
    {
        this(
            WxpayErrorCode.forCode(aErrorCode),
            null
        );
    }

    public WxpayException(int aErrorCode, Throwable cause)
    {
        this(
            WxpayErrorCode.forCode(aErrorCode),
            cause
        );
    }

  // EXCEPTION
    @Override
    public String getMessage()
    {
        return(this.errorCode!=null ? this.errorCode.getMsg() : null);
    }
}
