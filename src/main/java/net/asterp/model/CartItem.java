package net.asterp.model;

import java.util.Objects;

public class CartItem {
	private int productId;
	private String productName;
	private String imgBlob;
	private double unitPrice;
	private int quantity;

	public CartItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CartItem(int productId, String productName, String imgBlob, double unitPrice, int quantity) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.imgBlob = imgBlob;
		this.unitPrice = unitPrice;
		this.quantity = quantity;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImgBlob() {
		return imgBlob;
	}

	public void setImgBlob(String imgBlob) {
		this.imgBlob = imgBlob;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public int hashCode() {
		return Objects.hash(imgBlob, productId, productName, quantity, unitPrice);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CartItem other = (CartItem) obj;
		return productId == other.productId;
	}

}
