package net.asterp.model;

public class PaymentType {
	private int typeId;
	private String typeName;
	private String desc;

	public PaymentType() {
		super();
	}

	public PaymentType(int typeId, String typeName, String desc) {
		super();
		this.typeId = typeId;
		this.typeName = typeName;
		this.desc = desc;
	}

	/**
	 * @return the typeId
	 */
	public int getTypeId() {
		return typeId;
	}

	/**
	 * @param typeId the typeId to set
	 */
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	/**
	 * @return the typeName
	 */
	public String getTypeName() {
		return typeName;
	}

	/**
	 * @param typeName the typeName to set
	 */
	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
