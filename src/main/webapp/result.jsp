<%-- DIRETIVA tudo que começa com @ é uma diretiva --%>
<%@ page import="com.example.*,java.util.*,com.example.model.Movie"
	contentType="text/html; charset=UTF-8"%>
<%@taglib uri="DiceFunctions" prefix="mine"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="RandomThings" prefix="random"%>
<%@taglib prefix="myTags" tagdir="/WEB-INF/tags"%>
<%@taglib uri="simpleTags" prefix="simpleTags"%>
<%@taglib uri="classicTags" prefix="classicTags"%>


<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>J2EE JSP Lab</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>

<body>
	<myTags:Header subTitle="Este é o valor enviado por parâmetro">Texto do corpo da tag</myTags:Header>
	<main role="main">
	<section>
		<div class="container">
			<menu><%@ include file="menu.jsp"%></menu>
			<menu><jsp:include page="menu.jsp">
					<jsp:param name="subtitle"
						value="Teste de parametro no include via page" />
				</jsp:include></menu>
			<h1>Beer Recomendations JSP</h1>
			<h2>Busca atributo do request e transforma em um list</h2>
			<%
            List styles = (List)request.getAttribute("styles");
            Iterator iterator = styles.iterator();
    
            while (iterator.hasNext()) {
                out.print("<li>Try: " + iterator.next() + "</li>");
            }
            %>

			<hr />
			<h1>Session attribute Dog.</h1>
			<%= session.getAttribute("dogSession") %>

			<hr />
			<h1>Application Servlet Context attribute by
				ServletContextListener</h1>
			<%= application.getAttribute("dog") %>

			<hr />
			<h1>Expression Language (EL)</h1>
			Expression: ${1.2 + 2.3}<br> Expression: ${42 / 0}<br>
			Cookie: ${cookie.MyCookie.getValue()}<br> Init Param do
			contexto: ${initParam.appEmail}<br>

			<hr />
			<h1>Init Param e Context Param no JSP (diferente do servlet)</h1>
			<h2>Busca atributo no web.xml e anula o jspInit() do JSP para
				recuperar o valor</h2>
			<%!String servletJSPEmail = null;

	public void jspInit() {
		ServletConfig config = getServletConfig();
		this.servletJSPEmail = config.getInitParameter("servletJSPEmail");
	}%>
			Scriptlet:
			<%= this.servletJSPEmail %><br> EL buscando Servlet init
			parameter através do pageContext:
			${pageContext.getServletConfig().getInitParameter("servletJSPEmail")}<br>

			<hr />
			<h1>Atributos em JSP (buscando através dos quatro objetos
				implicitos)</h1>
			<li>Application attribute (set on listener): <%= application.getAttribute("dog") %></li>
			<li>Application attribute (set on servlet): <%= application.getAttribute("dogContext") %></li>
			<li>Request: <%= request.getAttribute("attributeA") %></li>
			<li>Session: <%= session.getAttribute("dogSession") %>
			</li>


			<% 
            float one = new Float(42.5);
            pageContext.setAttribute("foo", one);
            %>
			<li>Page: <%= pageContext.getAttribute("foo") %></li>
			<li>Page (buscando de outro contexto): <%= pageContext.getAttribute("dogSession", PageContext.SESSION_SCOPE) %></li>
			<li>Init Param do contexto: <%= application.getInitParameter("appEmail") %></li>

			<hr />
			<h1>EL Buscando objeto do escopo request</h1>
			<jsp:useBean id="dogRequest" class="com.example.listener.Dog"
				scope="request" />
			<jsp:getProperty name="dogRequest" property="breed" />

			<hr />
			<h1>EL Criando objeto com EL dentro do JSP</h1>
			<jsp:useBean id="dogEL" class="com.example.listener.Dog" scope="page">
				<jsp:setProperty name="dogEL" property="breed" value="Dog EL" />
			</jsp:useBean>
			<jsp:getProperty name="dogEL" property="breed" />

			<hr />
			<h1>Counter usando objeto estático</h1>
			<%= Counter.getCount() %>

			<hr />
			<h1>Counter do JSP</h1>
			<%!int count = 0;%>
			<%-- deve ser uma variavel da classe, não dentro do service (ou seja não pode ser na tread, pois é unica para cada requisição --%>
			<%= ++this.count %>

			<hr />
			<h1>Criando objeto Employeee subclasse de Person</h1>
			<jsp:useBean id="person" type="com.example.Person"
				class="com.example.Employee" scope="page">
				<jsp:setProperty name="person" property="name" value="Fred" />
			</jsp:useBean>
			<jsp:getProperty name="person" property="name" />

			<hr />
			<h1>Criando Bean e preenchendo com dados do Request</h1>
			<jsp:useBean id="person2" type="com.example.Person"
				class="com.example.Employee" scope="page">
				<jsp:setProperty name="person2" property="*" />
			</jsp:useBean>
			Name:
			<jsp:getProperty name="person2" property="name" /><br> ID:
			<jsp:getProperty name="person2" property="empID" />


			<hr />
			<h1>Buscar valor de subobjeto com a EL</h1>
			${employeeWithDog.dog.breed}<br>
			<br>

			<hr />
			<h1>Usando taglib</h1>
			${mine:rollIt()}<br>
			<br>

			<hr />
			<h1>Redirecionamento condicional usando JSTL</h1>
			<c:if test="${param.name == 'voltar'}">
				<jsp:forward page="form.html" />
			</c:if>

			<hr />
			<h1>JSTL Tag c:out</h1>
			<c:out value="${dogRequest.breed}" escapeXml="false" />

			<hr />
			<h1>JSTL Tag c:out com alternativa para null</h1>
			<c:out value="${evalsToNull}" default="Value default se for null" />

			<hr />
			<h1>JSTL Tag c:forEach</h1>
			<c:forEach var="movie" items="${movieList}" varStatus="count">
				<li>${count.count}- ${movie}</li>
			</c:forEach>

			<hr />
			<h1>JSTL Tag c:choose c:when and c:otherwise</h1>
			<c:choose>
				<c:when test="${param.name == 'alan'}">
                    Seu nome é alan
                </c:when>
				<c:when test="${param.name == 'fulano'}">
                    Seu nome é fulano
                </c:when>
				<c:otherwise>
                    seu nome é ${param.name}
                </c:otherwise>
			</c:choose>
			<br>

			<hr />
			<h1>JSTL c:set com var (variaveis de atributos)</h1>
			<c:set var="employeeDog" scope="session"
				value="${employeeWithDog.dog}" />

			<hr />
			<h1>JSTL c:set com target beans e maps</h1>
			<c:set target="${employeeWithDog.dog}" property="breed"
				value="Raça do cachorro setado com set target" />

			<hr />
			<h1>JSTL c:set com c:remove</h1>
			<c:set var="userStatus" scope="session" value="testeeeeee" />
			userStatus: ${userStatus}<br>
			<c:remove var="userStatus" scope="session" />
			userStatus: ${userStatus}<br>

			<hr />
			<h1>JSTL c:import</h1>
			<textarea>
                <c:import
					url="https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b1b15e88fa797225412429c1c50c122a1" />
            </textarea>

			<hr />
			<h1>JSTL c:catch capturando excessões</h1>
			<c:catch var="myException">
				<% int x = 10/0; %>
			</c:catch>
			<c:if test="${myException != null}">
                A excessão foi ${myException}<br>
			</c:if>

			<hr>
			<h1>Tag customizada</h1>
			<random:advice user="${param.name}" />

			<hr>
			<h1>Simple Tags com SimpleTagHandler</h1>
			<%
            List<Movie> movies = new LinkedList<Movie>();
            Movie movie1 = new Movie();
            Movie movie2 = new Movie();
            movie1.setName("O senhor do anéis");
            movie1.setGenre("Aventura");
            movie2.setName("De volta para o futuro");
            movie2.setGenre("Ficção");
            
            movies.add(movie1);
            movies.add(movie2);
            pageContext.setAttribute("movies", movies);
            %>

			<table border="1">
				<simpleTags:simple5 movieList="${movies}">
					<tr>
						<td>${movie.name}</td>
						<td>${movie.genre}</td>
					</tr>
				</simpleTags:simple5>
			</table>
			
			<hr>
			<h1>Classic Tags</h1>
			<table border="1">
				<classicTags:classic>
					<tr>
						<td>bunda ${classicMovie}</td>
					</tr>
				</classicTags:classic>
			</table>

			<hr />
			<h1>Objetos implicitos EL</h1>
			<textarea cols="100" rows="20">
                pageScope: ${pageScope}<br><br>

                requestScope: ${requestScope}<br><br>

                sessionScope: ${sessionScope}<br><br>

                applicationScope: ${applicationScope}<br><br>
                
                param: ${param}<br><br>

                paramValues: ${paramValues}<br><br>

                header: ${header}<br><br>

                headerValues: ${headerValues}<br><br>

                cookie ${cookie}<br><br>

                initParam ${initParam}<br><br>

                pageContext ${pageContext.getServletConfig().getInitParameter("servletJSPEmail")}<br><br>
            </textarea>

			<hr />
			<a
				href="<% out.print(response.encodeURL("/BeerExpert/form.html")); %>">Back</a><br>
			Reescrita com c:url <a href="<c:url value='/form.html'/>">Back</a><br>
			Reescrita com c:url e codificação de valores <a
				href="<c:url value='/form.html'><c:param name='firstName' value='First / name' /></c:url>">Back</a><br>

		</div>
	</section>
</body>
</html>