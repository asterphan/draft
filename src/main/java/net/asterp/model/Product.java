package net.asterp.model;

public class Product {
	private int productId;
	private String productName;
	private String description;
	private int categoryId;
	private double unitPrice;
//	private String imageURL;
	private String imgBlob;
	private String status;

	public Product() {
		super();
	}

	/**
	 * @return the imgBlob
	 */
	public String getImgBlob() {
		return imgBlob;
	}

	/**
	 * @param imgBlob the imgBlob to set
	 */
	public void setImgBlob(String imgBlob) {
		this.imgBlob = imgBlob;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		Product product = (Product) o;
		return productId == product.productId;
	}

}
