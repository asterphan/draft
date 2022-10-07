<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@page import="net.asterp.model.Invoice"%>
<%@page import="net.asterp.dao.InvoiceDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@ page language="java" contentType="application/pdf;"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
int orderId = Integer.parseInt(request.getParameter("orderId"));
System.out.print(orderId);
HashMap<String, Object> info = new InvoiceDAO().getOrderInfo(orderId);
ArrayList<Invoice> list = new InvoiceDAO().getProductDetail(orderId);

System.out.println(info.get("address").toString());

String jrxmlFile = session.getServletContext().getRealPath("/view/user/invoice/Invoice.jrxml");
InputStream input = new FileInputStream(new File(jrxmlFile));
JasperDesign jasperDesign = JRXmlLoader.load(input);

/*compiling jrxml with help of JasperReport class*/
JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);

/* Convert List to JRBeanCollectionDataSource */
JRBeanCollectionDataSource itemsJRBean = new JRBeanCollectionDataSource(list);

/* Map to hold Jasper report Parameters */
Map<String, Object> parameters = new HashMap<String, Object>();
parameters.put("cusName", info.get("customerName").toString());
parameters.put("cusEmail", info.get("email").toString());
parameters.put("invoiceNo", info.get("orderId").toString());
parameters.put("invoiceDate", info.get("orderDate").toString());
parameters.put("receiver", info.get("receiver").toString());
parameters.put("phone", info.get("phone").toString());
parameters.put("address", info.get("address").toString());

parameters.put("ProductDetailParam", itemsJRBean);

/* Using jasperReport object to generate PDF */
JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JREmptyDataSource());

/* Write content to PDF file */
JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

response.getOutputStream().flush();
response.getOutputStream().close();

System.out.println("File Generated");
%>