package net.asterp.model;

public class OrderStatus {
	private int statusId;
	private String desc;

	public OrderStatus() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderStatus(int statusId, String desc) {
		super();
		this.statusId = statusId;
		this.desc = desc;
	}

	/**
	 * @return the statusId
	 */
	public int getStatusId() {
		return statusId;
	}

	/**
	 * @param statusId the statusId to set
	 */
	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}

	/**
	 * @return the desc
	 */
	public String getDesc() {
		return desc;
	}

	/**
	 * @param desc the desc to set
	 */
	public void setDesc(String desc) {
		this.desc = desc;
	}

}
