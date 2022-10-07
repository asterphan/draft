<%@page import="java.util.List"%>
<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Product> list = new ProductDAO().getAll();
ArrayList<Category> cList = new CategoryDAO().getAll();
List<String> stt = new ProductDAO().getAllProductStt();

//Create a new Locale
Locale usa = new Locale("en", "US");
//Create a formatter given the Locale
NumberFormat dollarFormat = NumberFormat.getCurrencyInstance(usa);
%>
<div class="row prod-p">
	<div class="col-12 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">
					Product list <span><button type="button"
							class="btn btn-info mb-3" data-toggle="collapse"
							data-target="#filter-prod">
							<i class="fa fa-filter"></i>Filter
						</button>
						<button type="button" onclick="gotoAddProd()"
							class="btn btn-dark mb-3">Add new product</button></span>
				</h4>
				<div id="filter-prod" class="collapse">
					<form>
						<div class="row">
							<div class="col">
								<div class="form-group">
									<label class="col-form-label">By Category</label>
									<select class="custom-select" name="filter-prod-c">
										<option value="">All</option>
										<%
										if (cList != null) {
											for (Category c : cList) {
										%>
										<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
										<%
										}
										}
										%>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="form-group">
									<label class="col-form-label">By Status</label>
									<select class="custom-select" name="filter-prod-stt">
										<option value="">All</option>
										<%
										if (stt != null) {
											for (String s : stt) {
										%>
										<option value="<%=s%>"><%=s%></option>
										<%
										}
										}
										%>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="form-group">
									<label class="col-form-label">By Price Range</label>
									<input type="text" class="js-range-slider"
										name="filter-prod-price" value="" data-type="int" data-min="0"
										data-max="<%=new ProductDAO().generateMaxPriceRange()%>"
										data-from="0"
										data-to="<%=new ProductDAO().generateMaxPriceRange()%>"
										data-grid="false" data-prefix="$" />
								</div>
							</div>
							<div class="col-12">
								<button type="reset" class="btn btn-dark">Reset all
									filter</button>
							</div>
						</div>
					</form>
				</div>
				<div class="data-tables datatable-dark">
					<table id="dataTable-prod" class="text-center table-hover">
						<thead class="text-capitalize">
							<tr>
								<th>ID</th>
								<th>Image</th>
								<th>Name</th>
								<th>Category</th>
								<th>Unit price</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (list != null) {
								for (Product p : list) {
									Category c = new CategoryDAO().getById(p.getCategoryId());
							%>
							<tr>
								<td><%=p.getProductId()%></td>
								<td>
									<img alt="<%=p.getProductName()%>"
										src="data:image/jpg;base64,<%=p.getImgBlob()%>" width="80">
								</td>
								<td class="text-left"><%=p.getProductName()%></td>
								<td><%=c.getCategoryName()%></td>
								<td><%=dollarFormat.format(p.getUnitPrice())%></td>
								<td>
									<span
										class="badge <%if (p.getStatus().equals("Enabled"))
	out.print("badge-success");
else
	out.print("badge-dark");%>"><%=p.getStatus()%></span>
								</td>
								<td>
									<a href="?page=prodMng&t=pd&id=<%=p.getProductId()%>">
										<i class="fa fa-eye"></i>
									</a>
									<a
										href="<%if (p.getStatus().equals("Disabled"))
	out.print("javascript:void(0)");
else
	out.print("javascript:disableProd(" + p.getProductId() + ")");%>"
										class="del-prod-btn">
										<i class="fa fa-trash"></i>
									</a>
								</td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>