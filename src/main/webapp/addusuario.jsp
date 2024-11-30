<%@ page import="com.crudjspjava.dao.UsuarioDao, com.crudjspjava.bean.Usuario" %>
<jsp:useBean id="u" class="com.crudjspjava.bean.Usuario" scope="request"/>
<jsp:setProperty property="*" name="u"/>

<%
   int i = UsuarioDao.salvarUsuario(u);

   if (i > 0) {
       response.sendRedirect("usuarioform.jsp?status=success");
   } else {
       response.sendRedirect("usuarioform.jsp?status=error");
   }
%>
