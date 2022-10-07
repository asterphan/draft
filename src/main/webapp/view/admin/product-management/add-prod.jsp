<%@page import="net.asterp.dao.ProductDAO"%>
<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Category> cList = new CategoryDAO().getAll();
%>
<div class="row add-new-prod-p mt-5">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Add new product</h4>
				<form method="post" action="/NasaSpaceStore/ProductServlet"
					class="row" style="width: 100%;" name="add-new-prod"
					enctype="multipart/form-data">
					<input type="hidden" name="action" value="addNewProd" />
					<div class="col-8">
						<div class="form-group row">
							<label for="prod-name" class="col-3 col-form-label">Product
								name</label>
							<div class="col-9">
								<input type="text" class="form-control" name="prod-name" placeholder="Product name"
									required>
							</div>
							<div class="form-control-feedback offset-3 col-9 mt-1"></div>
						</div>
						<div class="form-group row">
							<label for="prod-desc" class="col-3 col-form-label">Description</label>
							<div class="col-9">
								<textarea rows="3" cols="" name="prod-desc" class="form-control" placeholder="Description"
									required></textarea>
							</div>
							<div class="form-control-feedback offset-3 col-9 mt-1"></div>
						</div>
						<div class="form-group row">
							<label for="prod-category" class="col-3 col-form-label">Category</label>
							<div class="col-9">
								<select class="custom-select" name="prod-category">
									<%
									for (Category c : cList) {
									%>
									<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>
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
									aria-label="Amount (to the nearest dollar)" name="prod-price" placeholder="0.00"
									required>
							</div>
							<div class="form-control-feedback offset-3 col-9 mt-1"></div>
						</div>
						<div class="form-group row">
							<div class="offset-3 col-9">
								<button type="reset" class="btn btn-secondary">Reset</button>
								<button type="submit" class="btn btn-dark">Submit</button>
							</div>
							
						</div>
					</div>
					<div class="col-4">
						<div class="form-group">
							<label for="staticEmail" class="col-form-label">Product
								image</label>
							<div class="row">
								<img alt="" src="" class="rounded float-left prod-img-tag"
									style="width: 60%; margin: auto;" />
							</div>
							<div class="custom-file">
								<input type="file" class="custom-file-input" id="prod-img-file"
									name="prod-img-file" accept="image/*" required>
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