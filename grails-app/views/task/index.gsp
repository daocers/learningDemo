
<%@ page import="co.bugu.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript library="jquery"/>
    <g:javascript>

        $(document).ready(function () {
            $('#newForm').hide();
            $('#button').click(function () {
                $.ajax({
                    type:"GET",
                    url:"/file/music.txt",
                    dataType:"json",
                    success:function (data) {
                        alert("god");
                        var music = "<ul>";

                        $.each(data, function (i, n) {
                            music += "<li>" + n["optionValue"] + "</li>";
                        });

                        music += "</ul>";

                        $('#result').append(music);
                    }
                });

                return false;
            });
        });


        //        $(function(){
        //            $('#button').click(function(){
        //                $.getJSON('view/music.txt', function(data){
        //                    var music = "<ul>" ;
        //                    $.each(data, function(i, n){
        //                        music += "<li>" + n["optionValue"] + "</li>";
        //                    });
        //                    music +="</ul>";
        //
        //                    $('#result').append(music);
        //                });
        //
        //                return false;
        //            });
        //        });

        function addForm() {
//            S("#addForm").append(
////                    '<input type="text" name="event"/>'
////                    aaa
//                    alert("good")
//            )
            alert("good")
        }

        function showTask() {
            $.getJSON("showTask", {id:"1"}, function (task) {
                alert(task.event);

            })
        }

        function show() {
            $.ajax({
                type:"GET",
                url:"showTask",
                dataType:"json",
                success:function (data) {
                    alert(data.event);
                }
            })
        }

        function ajaxDelete(){

                var tr_id = "tr_" + $('#id').attr('value')
              $.ajax({
                type:"post",
                url:"ajaxDelete",
                data:{id: $('#id').attr('value')},
                success:function (data) {
                    $('#message').html(data);
//                    alert(tr_id)

                    $("#"+tr_id).remove();   //删除数据后删除行
                }
            })
        }


        function listTask() {
            $('#tbody').empty();  //清除内容，防止重复
            $.ajax({
                type:"GET",
                url:"listTask",
                dataType:"json",
                success:function (data) {
                    var task = "";
                    var st;

                    $.each(data, function (i, n) {
                        if (i % 2 == 0) {
                            st = "even";
                        } else {
                            st = "odd";
                        }

                        task += "<tr id = 'tr_" + n.id + "'class='" + st + "'><td>" + n.event +
                                "</td>" ;

                        task += "<td><form><input id='id' type='hidden' name='id' value='" +n.id + "'/> <input type='button' value='delete' onclick='ajaxDelete()'/></form></td></tr>"
                        %{--task += "<td><form><input type='hidden' name='id' value='" +n.id + "'/> <g:submitToRemote action='ajaxDelete' ></g:submitToRemote></form></td></tr>"无法实现功能--}%

                        %{--task += "<td><form action='delete'>" +--}%
    %{--"<input type='hidden' name='id' value='"+n.id +"' />" +--}%
    %{--"<g:submitToRemote action="delete" update="[success: 'message', failure: 'error']" /> " +--}%
        %{--"</form></td>"--}%
                    });


                    $('#tbody').append(task);

                }
            });
        };

        function addTask(){
            $('#newForm').show();
        }



    </g:javascript>
</head>
<body>
<a href="#list-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
        <li><a href="#" onclick="addTask()">New Task</a> </li>
        <li><g:remoteLink action="listTask" onSuccess="listTask()" update="message">listTask</g:remoteLink> </li>
    </ul>
</div>
<div id="list-task" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div id="message"></div>
    <div id="error"></div>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="event" title="${message(code: 'task.event.label', default: 'Event')}" />
            <td></td>

        </tr>

        </thead>

        <tbody>
            <div id="tbody"></div>


        </tbody>




    </table>


    <div id="newForm">
        <form action="ajaxAdd">
          event:  <input type="text" name="event">

            <g:submitToRemote action="ajaxAdd" update="[success:'message', failure:'error']" onSuccess="listTask()" onComplete="" value="add"></g:submitToRemote>

        </form>

    </div>
</div>


%{--<div>点击获取json数据</div>--}%
%{--<input type="button" id="button" value="确定"/>--}%
%{--<div id="result"></div>--}%
</body>
</html>
