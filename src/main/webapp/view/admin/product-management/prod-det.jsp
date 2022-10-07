<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lowagie.text.List"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.model.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
int prodId = Integer.parseInt(request.getParameter("id"));
Product p = new ProductDAO().getProductById(prodId);
ArrayList<Category> cList = new CategoryDAO().getAll();
%>
<div class="pl-back mt-3 mb-3">
	<a href="?page=prodMng&t=pl">
		<i class="fa fa-angle-left"></i>Back
	</a>
</div>
<div class="row prod-d-p">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">
					Product Details <span><a data-toggle="collapse"
							href="#edit-prod-inf" role="button" aria-expanded="false"
							aria-controls="collapseExample">
							<i class="fa fa-pencil"></i>Edit
						</a></span>
				</h4>
				<form method="post" action="/NasaSpaceStore/ProductServlet"
					class="row" style="width: 100%;" name="prod-d-inf"
					enctype="multipart/form-data">
					<input type="hidden" name="action" value="editProd" />
					<div class="col-8">
						<div class="form-group row">
							<label for="prod-id" class="col-3 col-form-label">Product
								ID</label>
							<div class="col-9">
								<input type="text" readonly class="form-control" name="prod-id"
									value="<%=p.getProductId()%>">
							</div>
						</div>
						<div class="form-group row">
							<label for="prod-name" class="col-3 col-form-label">Product
								name</label>
							<div class="col-9">
								<input type="text" readonly class="form-control"
									name="prod-name" value="<%=p.getProductName()%>" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="prod-desc" class="col-3 col-form-label">Description</label>
							<div class="col-9">
								<textarea rows="3" cols="" name="prod-desc" class="form-control"
									readonly required><%=p.getDescription()%></textarea>
							</div>
						</div>
						<div class="form-group row">
							<label for="prod-category" class="col-3 col-form-label">Category</label>
							<div class="col-9">
								<select class="custom-select" name="prod-category" disabled>
									<%
									for (Category c : cList) {
									%>
									<option value="<%=c.getCategoryId()%>"
										<%if (c.getCategoryId() == p.getCategoryId())
	out.print("selected");%>><%=c.getCategoryName()%>
									</option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="prod-price" class="col-3 col-form-label">Unit
								price</label>
							<div class="col-9 input-group">
								<div class="input-group-prepend">
									<span class="input-group-text">$</span>
								</div>
								<input type="text" class="form-control"
									aria-label="Amount (to the nearest dollar)"
									value="<%=p.getUnitPrice()%>" name="prod-price" readonly
									required>
							</div>
						</div>
						<div class="form-group row stt">
							<label for="staticEmail" class="col-3 col-form-label">Status</label>
							<div class="col-9">
								<span
									class="badge <%if (p.getStatus().equals("Enabled"))
	out.print("badge-success");
else
	out.print("badge-dark");%>"><%=p.getStatus()%></span>
							</div>
						</div>
						<div class="collapse row" id="edit-prod-inf">
							<div class="offset-3 col-9">
								<button type="reset" class="btn btn-secondary"
									data-toggle="collapse" data-target="#edit-prod-inf">Cancel</button>
								<button type="submit" class="btn btn-dark"
									name="update-prod-inf-btn"
									<%if (p.getStatus().equals("Disabled"))
	out.print("disabled");%>>Submit</button>
								<span><button type="button" class="btn btn-danger"
										name="inner-del-prod-btn"
										<%if (p.getStatus().equals("Disabled"))
	out.print("disabled");%>>
										<i class="fa fa-trash"></i>Disable
									</button></span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-9 offset-3">
								<button type="button" class="btn btn-danger"
									name="outer-del-prod-btn"
									<%if (p.getStatus().equals("Disabled"))
	out.print("disabled");%>>
									<i class="fa fa-trash"></i>Disable
								</button>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="form-group">
							<label for="staticEmail" class="col-form-label">Product
								image</label>
							<div class="row">
								<img alt="<%=p.getProductName()%>"
									src="data:image/jpg;base64,<%=p.getImgBlob()%>"
									class="rounded float-left prod-img-tag"
									style="width: 60%; margin: auto;" />
							</div>
							<div class="custom-file">
								<input type="file" class="custom-file-input" id="prod-img-file"
									name="prod-img-file" accept="image/*">
								<label class="custom-file-label" for="prod-img">Choose
									image</label>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>