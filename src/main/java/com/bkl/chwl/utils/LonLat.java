package com.bkl.chwl.utils;
/**
 * 有关经纬度计算的工具
 * @author zjf
 * @version 1.0 2011-2-23
 */
public class LonLat 
{
	public static final double R = 6371.004;
	
	/**
	 * 根据给定的两个经纬度计算两地之间的距离，单位km
	 * @param lon1	经度1
	 * @param lat1	纬度1
	 * @param lon2	经度2
	 * @param lat2	纬度2
	 * @return	两地距离
	 */
	public static double getDistance(double lon1, double lat1, double lon2, double lat2)
	{
		double x = changeToRad(lon1);
		double y = changeToRad(lat1);
		double a = changeToRad(lon2);
		double b = changeToRad(lat2);
		double rad = Math.acos(Math.cos(y) * Math.cos(b) * Math.cos(x - a) + Math.sin(y) * Math.sin(b));
		if (rad > Math.PI)
			rad = Math.PI * 2 - rad;
		return R * rad;
	}
	
	/**
	 * 将角度转化为弧度
	 * @param angle	角度
	 * @return	弧度
	 */
	public static double changeToRad(double angle)
	{
		return angle / 180 * Math.PI;
	}
	
	public static void main(String[] args)
	{
		System.out.println(getDistance(106.510865,29.597842, 106.567974,29.534636));
	}
	
//	@Test
//	public void sort(){
//		//shopinfos是需要排序的数组 
//		Collections.sort(shopInfos, new Comparator<ShopListInfo>() { 
//			@Override 
//			public int compare(ShopListInfo lhs, ShopListInfo rhs){ 
//				//我的所在的坐标位置 
//				GeoPoint myGeoPoint = (GeoPoint) NaniApplication .getInstance().getObjectMap().get("myGeo"); 
//				//计算前一个坐标与我的距离
//				GeoPoint geoPoint1 = new GeoPoint((int) (Double .valueOf(lhs.getLat()) * 1E6), (int) (Double.valueOf(lhs.getLng()) * 1E6)); 
//				//计算后一个坐标与我的距离 
//				GeoPoint geoPoint2 = new GeoPoint((int) (Double .valueOf(rhs.getLat()) * 1E6), (int) (Double.valueOf(rhs.getLng()) * 1E6)); 
//				//返回计算后的差值 
//				return (int) (DistanceUtil.getDistance(myGeoPoint, geoPoint1) - DistanceUtil.getDistance( myGeoPoint, geoPoint2)); } 
//			});
//			}
//		}
//	}
}
