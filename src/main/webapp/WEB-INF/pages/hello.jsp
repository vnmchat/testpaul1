<html>
<head>
    <script type="text/javascript" src="https://js.balancedpayments.com/1.1/balanced.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(document).ready(function () {
    // Callback for handling responses from Balanced
    function handleResponse(response) {
        // Successful tokenization
        if (response.status_code === 201) {
            var fundingInstrument = response.cards != null ? response.cards[0] : response.bank_accounts[0];
            // Call your backend
            jQuery.post("/path/to/your/backend", {
                uri: fundingInstrument.href
            }, function(r) {
                // Check your backend response
                if (r.status === 201) {
                    // Your successful logic here from backend ruby
                } else {
                    // Your failure logic here from backend ruby
                }
            });
        } else {
            // Failed to tokenize, your error logic here
        }

        // Debuging, just displays the tokenization result in a pretty div
        $('#response .panel-body pre').html(JSON.stringify(response, false, 4));
        $('#response').slideDown(300);
    }

    // Click event for tokenize credit card
    $('#cc-submit').click(function (e) {
        e.preventDefault();

        $('#response').hide();

        var payload = {
            name: $('#cc-name').val(),
            number: $('#cc-number').val(),
            expiration_month: $('#cc-ex-month').val(),
            expiration_year: $('#cc-ex-year').val(),
            security_code: $('#ex-csc').val()
        };

        // Tokenize credit card
        balanced.card.create(payload, handleResponse);
    });

    // Click event for tokenize bank account
    $('#ba-submit').click(function (e) {
        e.preventDefault();

        $('#response').hide();

        var payload = {
            name: $('#ba-name').val(),
            account_number: $('#ba-number').val(),
            routing_number: $('#ba-routing').val()
        };

        // Tokenize bank account
        balanced.bankAccount.create(payload, handleResponse);
    });

    // Simply populates credit card and bank account fields with test data
    $('#populate').click(function () {
        $(this).attr("disabled", true);

        $('#cc-name').val('John Doe');
        $('#cc-number').val('4111111111111111');
        $('#cc-ex-month').val('12');
        $('#cc-ex-year').val('2020');
        $('#ex-csc').val('123');
        $('#ba-name').val('John Doe');
        $('#ba-number').val('9900000000');
        $('#ba-routing').val('321174851');
    });
});
</script>

</head>
<body>
<div class="container">
    <h3>${message}</h3>
    <div class="row">
        <div class="col-lg-12">
            <div class="alert alert-info">
                <p>Do not provide real credit card or bank account details into these forms. Instead use <a href="https://docs.balancedpayments.com/current/overview.html#test-credit-card-numbers" class="alert-link" target="_blank">test cards</a> and <a href="https://docs.balancedpayments.com/current/overview.html#test-bank-account-numbers" class="alert-link" target="_blank">bank accounts</a>.</p>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <button type="button" id="populate" class="btn btn-default pull-right" style="margin-bottom: 20px;">Populate Test Data</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Tokenize Credit Card</h3>
                </div>
                <div class="panel-body">
                    <form role="form" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Name on Card</label>
                            <div class="col-lg-5">
                                <input type="text" id="cc-name" class="form-control" autocomplete="off" placeholder="John Doe" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Card Number</label>
                            <div class="col-lg-5">
                                <input type="text" id="cc-number" class="form-control" autocomplete="off" placeholder="4111111111111111" maxlength="16" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Expiration</label>
                            <div class="col-lg-2">
                                <input type="text" id="cc-ex-month" class="form-control" autocomplete="off" placeholder="01" maxlength="2" />
                            </div>
                            <div class="col-lg-2">
                                <input type="text" id="cc-ex-year" class="form-control" autocomplete="off" placeholder="2013" maxlength="4" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Security Code (CSC)</label>
                            <div class="col-lg-2">
                                <input type="text" id="ex-csc" class="form-control" autocomplete="off" placeholder="453" maxlength="4" />
                            </div>
                        </div>
                        <a id="cc-submit" class="btn btn-large btn-primary pull-right">Tokenize</a>

                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Tokenize Bank Account</h3>
                </div>
                <div class="panel-body">
                    <form role="form" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Account Holder's Name</label>
                            <div class="col-lg-6">
                                <input type="text" id="ba-name" class="form-control" autocomplete="off" placeholder="John Doe" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Routing Number</label>
                            <div class="col-lg-6">
                                <input type="text" id="ba-routing" class="form-control" autocomplete="off" placeholder="322271627" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-5 control-label">Account Number</label>
                            <div class="col-lg-6">
                                <input type="text" id="ba-number" class="form-control" autocomplete="off" placeholder="9900000000" />
                            </div>
                        </div>
                        <a id="ba-submit" class="btn btn-large btn-primary pull-right">Tokenize</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div id="response" class="col-lg-12" style="display: none;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Response</h3>
                </div>
                <div class="panel-body">
                    <pre></pre>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>


