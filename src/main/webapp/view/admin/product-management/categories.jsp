<%@page import="net.asterp.dao.CategoryDAO"%>
<%@page import="net.asterp.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ArrayList<Category> cList = new CategoryDAO().getAll();
%>
<div class="row cate-p">
	<div class="col-7 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Category list</h4>
				<div class="data-tables datatable-dark">
					<table id="dataTable-categories" class="text-center table-hover">
						<thead class="text-capitalize">
							<tr>
								<th>Category ID</th>
								<th>Category name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (cList != null) {
								for (Category c : cList) {
							%>
							<tr>
								<td><%=c.getCategoryId()%></td>
								<td><%=c.getCategoryName()%></td>
								<td>
									<a href="#edit-c-form" data-toggle="collapse">
										<i class="fa fa-edit"></i>
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
	<div class="col-5 mt-5">
		<div class="card">
			<div class="card-body">
				<h4 class="header-title">Add new category</h4>
				<form name="add-new-category">
					<div class="form-group">
						<label for="category-name">Category name</label>
						<input type="text" name="category-name" class="form-control"
							placeholder="Category name" required />
					</div>
					<div class="form-group">
						<button type="reset" class="btn btn-secondary">Reset</button>
						<button type="submit" class="btn btn-dark">Submit</button>
					</div>
				</form>
				<div id="edit-c-form" class="collapse">
					<h4 class="header-title">Edit category</h4>
					<form name="edit-c-form">
						<div class="form-group">
							<label>Category ID</label>
							<input type="text" name="c-id" class="form-control" readonly />
						</div>
						<div class="form-group">
							<label>Current name</label>
							<input type="text" name="cur-c-name" class="form-control"
								readonly />
						</div>
						<div class="form-group">
							<label>New name</label>
							<input type="text" name="new-c-name" class="form-control"
								placeholder="New name" required />
						</div>
						<div class="form-group">
							<button type=button class="btn btn-secondary">Reset</button>
							<button type="submit" class="btn btn-dark">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>