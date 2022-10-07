package net.asterp.model;

public class Address {
	private int addrId;
	private String email;
	private String firstName;
	private String lastName;
	private String phone;
	private String country;
	private String province;
	private String district;
	private String ward;
	private String detail;
	private String status;
	private boolean isDefault;

	public Address() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Address(int addrId, String email, String firstName, String lastName, String phone, String country,
			String province, String district, String ward, String detail, String status, boolean isDefault) {
		super();
		this.addrId = addrId;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phone = phone;
		this.country = country;
		this.province = province;
		this.district = district;
		this.ward = ward;
		this.detail = detail;
		this.status = status;
		this.isDefault = isDefault;
	}

	public int getAddrId() {
		return addrId;
	}

	public void setAddrId(int addrId) {
		this.addrId = addrId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isDefault() {
		return isDefault;
	}

	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}
	
	public String getFullname() {
		return firstName + " " + lastName;
	}

}
