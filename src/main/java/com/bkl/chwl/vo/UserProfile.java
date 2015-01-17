package com.bkl.chwl.vo;

public class UserProfile {
	private double coin;
	private int bigbouns;
	private int mediumbouns;
	private int smallbouns;
	private int lottoTime;
	
	public int getLottoTime() {
		return lottoTime;
	}
	public void setLottoTime(int lottoTime) {
		this.lottoTime = lottoTime;
	}
	public double getCoin() {
		return coin;
	}
	public void setCoin(double coin) {
		this.coin = coin;
	}
	public int getBigbouns() {
		return bigbouns;
	}
	public void setBigbouns(int bigbouns) {
		this.bigbouns = bigbouns;
	}
	public int getMediumbouns() {
		return mediumbouns;
	}
	public void setMediumbouns(int mediumbouns) {
		this.mediumbouns = mediumbouns;
	}
	public int getSmallbouns() {
		return smallbouns;
	}
	public void setSmallbouns(int smallbouns) {
		this.smallbouns = smallbouns;
	}
	
}
