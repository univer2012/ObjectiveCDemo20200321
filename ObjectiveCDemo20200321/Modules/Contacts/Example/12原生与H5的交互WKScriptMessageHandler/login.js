<head>
    <meta charset="UTF-8">
    <title>walletProj</title>
</head>

<body>
    <script type="text/javascript">

        //无参数函数
        function testA() {
            window.webkit.messageHandlers.jsCallOc.postMessage("");
        }

        //有参数函数
        function testB(value) {
            window.webkit.messageHandlers.jsCallOc.postMessage("call oc");
        }

        function testC(value) {

            var finalObj = { "name": "chaman", "age": "18", "sex": "male" };
            window.webkit.messageHandlers.jsCallOc.postMessage(finalObj);
        }
    </script>

</body>

</html>
