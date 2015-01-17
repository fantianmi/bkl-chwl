package com.bkl.chwl.vo;

import com.baiyi.data.model.BigBouns;
import com.baiyi.data.model.CoinLog;
import com.baiyi.data.model.MiddleBouns;
import com.baiyi.data.model.OrderLog;
import com.baiyi.data.model.ProxyUser;
import com.bkl.chwl.vo.SellLog;
import com.baiyi.data.model.SmallBouns;
import com.baiyi.data.model.User;
import com.baiyi.data.model.User2;
import com.baiyi.domain.AddCoinEntity;
import com.baiyi.domain.BounsEntity;
import com.baiyi.domain.CoinLogEntity;
import com.baiyi.domain.LotteryEntity;
import com.baiyi.domain.OrderLogEntity;
import com.bkl.chwl.vo.SellLogEntity;
import com.baiyi.domain.UserInfoEntity;
import com.bkl.chwl.vo.UserListEntity;
import java.io.IOException;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.client.ClientProtocolException;

public class WebApi
{
  public static void init(String serverUrl, String authKey, String authPass)
  {
    HttpUtil.init(serverUrl, authKey, authPass);
  }

  public static UserInfoEntity getUser(int uid)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/user/get/" + uid + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());
    Map classMap = new HashMap();
    classMap.put("smallBouns", SmallBouns.class);

    classMap.put("middleBouns", MiddleBouns.class);

    classMap.put("bigBouns", BigBouns.class);

    UserInfoEntity user = (UserInfoEntity)JSONObject.toBean(jsonObject, UserInfoEntity.class, classMap);

    return user;
  }

  public static Double getCoin(int uid)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/coin/user/" + uid + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    return Double.valueOf(jsonObject.getDouble("coin"));
  }

  public static User register(int uid, String uname, int parent, int type, int local, int local2)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/user/register.json", "uid=" + uid + "&username=" + uname + "&parent=" + parent + "&type=" + type + "&local=" + local + "&local2=" + local2);
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    User user = (User)JSONObject.toBean(jsonObject, User.class);
    return user;
  }

  public static AddCoinEntity order(int uid, int type, int coin, int seller, String orderid)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/coin/add/" + type + "/" + uid + ".json", "coin=" + coin + "&seller=" + seller + "&orderid=" + orderid);
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    AddCoinEntity entity = (AddCoinEntity)JSONObject.toBean(jsonObject, AddCoinEntity.class);

    return entity;
  }

  public static AddCoinEntity withDraw(int uid, int coin)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/coin/withdraw/" + uid + ".json", "coin=" + coin);
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    AddCoinEntity entity = (AddCoinEntity)JSONObject.toBean(jsonObject, AddCoinEntity.class);

    return entity;
  }

  public static BounsEntity openBouns(int type, int bounsId)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/coin/bouns/open/" + type + "/" + bounsId + ".json", "");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    BounsEntity entity = (BounsEntity)JSONObject.toBean(jsonObject, BounsEntity.class);

    return entity;
  }

  public static AddCoinEntity translate(int fromUid, int toUid, int coin)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/coin/translate.json", "uid=" + fromUid + "&other=" + toUid + "&coin=" + coin);
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    AddCoinEntity entity = (AddCoinEntity)JSONObject.toBean(jsonObject, AddCoinEntity.class);

    return entity;
  }

  public static CoinLogEntity getCoinLog(int uid, int from, int pageNum)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/coin/history/" + from + "/" + pageNum + "/" + uid + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    Map classMap = new HashMap();
    classMap.put("list", CoinLog.class);
    CoinLogEntity entity = (CoinLogEntity)JSONObject.toBean(jsonObject, CoinLogEntity.class, classMap);

    return entity;
  }

  public static OrderLogEntity getOrderLog(int uid, int from, int pageNum)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/order/history/buyer/" + from + "/" + pageNum + "/" + uid + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    Map classMap = new HashMap();

    classMap.put("list", OrderLog.class);
    OrderLogEntity entity = (OrderLogEntity)JSONObject.toBean(jsonObject, OrderLogEntity.class, classMap);

    return entity;
  }

  public static SellLogEntity getSellLog(int uid, int from, int pageNum)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/order/history/seller/" + from + "/" + pageNum + "/" + uid + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    Map classMap = new HashMap();

    classMap.put("list", com.bkl.chwl.vo.SellLog.class);
    SellLogEntity entity = (SellLogEntity)JSONObject.toBean(jsonObject, SellLogEntity.class, classMap);

    return entity;
  }

  public static ProxyUser[] getAllProxy()
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/proxy/all.json");
    JSONArray jsonObject = JSONArray.fromObject(result.toString());

    Map classMap = new HashMap();

    ProxyUser[] list = (ProxyUser[])JSONArray.toArray(jsonObject, ProxyUser.class);

    return list;
  }

  public static void setProxy(int uid, int local, int local2, int type, int parent)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/proxy/register.json", "uid=" + uid + "&loc1=" + local + "&loc2=" + local2 + "&type=" + type + "&parent=" + parent);
  }

  public static LotteryEntity doLottery(int uid)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.post("/coin/lottery/" + uid + ".json", "");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());
    System.out.println("JSONObject" + result);
    LotteryEntity entity = (LotteryEntity)JSONObject.toBean(jsonObject, LotteryEntity.class);

    return entity;
  }

  public static UserListEntity getRecommendUserList(int uid, int from, int type, int pageNum)
    throws ClientProtocolException, IOException
  {
    String result = HttpUtil.get("/user/recommendlist/" + from + "/" + pageNum + "/" + uid + "/" + type + ".json");
    JSONObject jsonObject = JSONObject.fromObject(result.toString());

    Map classMap = new HashMap();

    classMap.put("list", User2.class);
    UserListEntity entity = (UserListEntity)JSONObject.toBean(jsonObject, UserListEntity.class, classMap);

    return entity;
  }
}