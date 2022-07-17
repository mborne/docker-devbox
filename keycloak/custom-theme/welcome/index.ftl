<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
  <title>Welcome to ${productNameFull}</title>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="robots" content="noindex, nofollow">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

  <link rel="stylesheet" href="${resourcesCommonPath}/node_modules/bootstrap/dist/css/bootstrap.min.css" />
  <link rel="stylesheet" href="${resourcesCommonPath}/node_modules/bootstrap/dist/css/bootstrap-theme.min.css" />
  <link rel="stylesheet" href="${resourcesPath}/css/welcome.css" />
</head>

<body>
  <div class="container-fluid">
    <h1>DEVBOX</h1>

    <p class="alert alert-warning">
    WARNING : This is a test instance.
    </p>

    <h2>User</h2>

    <ul>
      <li><a href="/auth/realms/master/account/">Manage your account</a></li>
    </ul>

    <h2>Developers</h2>

    <ul>
      <li><a href="/auth/realms/master/.well-known/openid-configuration">openid-configuration for master realm</a></li>
    </ul>

    <h2>Administration</h2>

    <ul>
      <li><a href="/auth/admin/">Manage keycloak</a></li>
    </ul>
  </div>

  <script type="text/javascript" src="${resourcesCommonPath}/node_modules/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="${resourcesCommonPath}/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
</body>

</html>
