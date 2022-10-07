package net.asterp.model;

import java.time.LocalDateTime;

public class Order {
	private int orderId;
	private String email;
	private int addressId;
	private LocalDateTime orderDate;
	private int paymentType;
	private int statusId;
	private String note;

	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Order(int orderId, String email, int addressId, LocalDateTime orderDate, int paymentType, int statusId,
			String note) {
		super();
		this.orderId = orderId;
		this.email = email;
		this.addressId = addressId;
		this.orderDate = orderDate;
		this.paymentType = paymentType;
		this.statusId = statusId;
		this.note = note;
	}

	/**
	 * @return the orderId
	 */
	public int getOrderId() {
		return orderId;
	}

	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the addressId
	 */
	public int getAddressId() {
		return addressId;
	}

	/**
	 * @param addressId the addressId to set
	 */
	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	/**
	 * @return the orderDate
	 */
	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	/**
	 * @param orderDate the orderDate to set
	 */
	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	/**
	 * @return the paymentType
	 */
	public int getPaymentType() {
		return paymentType;
	}

	/**
	 * @param paymentType the paymentType to set
	 */
	public void setPaymentType(int paymentType) {
		this.paymentType = paymentType;
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
	 * @return the note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}

}
