<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.java.myDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<div>
    <table id="tab1" class="display cell-border" style="width:100%;">
        <thead>
        <tr>
            <th>Lab Name</th>
            <th>From</th>
            <th>To</th>


        </tr>
        </thead>
        <tbody>
        <%
            Date date;
            String date1;
            int day;
            try {
                date1 = request.getParameter("date");

                date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
                day = date.getDay();
                Connection con = myDB.getCon();
                PreparedStatement stmt = con.prepareStatement("select * from lab_time inner join" +
                        " lab_details on lab_time.lab_no = lab_details.lab_no " +
                        "where lab_time.avail_day = ?");
                stmt.setInt(1, day);

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {


                    out.print("<tr>");
                    out.print("<td>");
                    out.print("<button class='mybtn' onclick='openLabDetails(this)' data-lab='" + rs.getString("lab_id") + "'>");
                    out.print("<h4>"+rs.getString(2)+"</h4>");
                    out.print("</td>");
                    out.print("<td>");
                    out.print("<h4>"+rs.getString("from_time")+"</h4>");
                    out.print("</td>");
                    out.print("<td>");
                    out.print("<h4>"+rs.getString("to_time")+"</h4>");
                    out.print("</td>");
                    out.print("</tr>");

                }


            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>


</div>

<script>

    function openLabDetails(e) {
        var lab_no = $(e).data("lab");
        $("#labs").load("jsp/labs.jsp?lab_name=" + lab_no);
        console.log("Lab NO:"+lab_no);
        $("#labs").show();
        $([document.documentElement, document.body]).animate({
            scrollTop: $("#labs").offset().top - 60
        }, 2000);
    }
</script>
