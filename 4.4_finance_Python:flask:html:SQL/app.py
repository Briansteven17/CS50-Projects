import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():

    data_user = db.execute(
        "SELECT symbol, SUM(shares) AS total_shares, type FROM transactions WHERE userid = ? GROUP BY symbol, type", session["user_id"])

    # Dictionary to store all the data display in homepage
    data = []
    for i in range(0, len(data_user), 1):
        index_data = {}
        symbol = data_user[i]["symbol"]

        if data_user[i]["type"] == "BUY":
            share_buy = data_user[i]["total_shares"]
            stock = lookup(symbol)
            symbol_current_price = float(stock["price"])

            total_value = symbol_current_price * share_buy

            # Pass data requested from SQL to the dictionary
            index_data["symbol"] = symbol
            index_data["share"] = share_buy
            index_data["price"] = symbol_current_price
            index_data["total"] = total_value

            data.append(index_data)

        # For transactions type SELL
        else:
            share_sell = data_user[i]["total_shares"]
            share_buy = 0
            for n in range(0, len(data), 1):
                if data[n]["symbol"] == symbol:
                    data[n]["share"] -= share_sell
                    data[n]["total"] = data[n]["share"] * data[n]["price"]
                    break

    user_cash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])

    cash = user_cash[0]["cash"]

    portafolio_value = 0
    for i in range(0, len(data), 1):
        portafolio_value += data[i]["total"]
        data[i]["price"] = usd(data[i]["price"])
        data[i]["total"] = usd(data[i]["total"])

    net_worth = cash + portafolio_value

    """Show portfolio of stocks"""
    return render_template("index.html", data=data, cash=usd(cash), net_worth=usd(net_worth))


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    if request.method == "POST":
        symbol = request.form.get("symbol")
        shares = request.form.get("shares")
        stock = lookup(symbol)

        # Check not valid inputs and return apology
        if not symbol or not shares or stock == None:
            return apology("Please provide valid stock and number of shares", 400)
        elif type(shares) == float or str.isnumeric(shares) == False:
            return apology("Please provide integer positive number", 400)
        elif int(shares) <= 0:
            return apology("Please provide integer positive number", 400)

        number_shares = int(shares)

        price_stock = float(stock["price"])
        company = stock["name"]

        total_amount = number_shares * price_stock

        id = session["user_id"]

        user = db.execute("SELECT * FROM users WHERE id = ?", id)

        user_cash = user[0]["cash"]

        current_cash = user_cash - total_amount
        type_buy = "BUY"
        sellprice = 0

        # Check is the user have enough cash for buying the shares
        if user_cash >= total_amount:
            db.execute("INSERT INTO transactions (symbol, company, shares, buyprice, sellprice, userid, type) VALUES (?, ?, ?, ?, ?, ?, ?)",
                       symbol, company, number_shares, price_stock, sellprice, id, type_buy)
            db.execute("UPDATE users SET cash = ? WHERE id = ?", current_cash, id)

        else:
            return apology("Sorry you do not have enough money to buy this amount of shares", 400)

    else:
        return render_template("buy.html")

    """Buy shares of stock"""
    user_data = db.execute("SELECT *, (buyprice + sellprice) AS price FROM transactions WHERE userid = ?", session["user_id"])
    n = 0
    for i in range(0, len(user_data), 1):
        n += 1
        user_data[i]["total"] = usd(user_data[i]["price"] * (user_data[i]["shares"]))
        user_data[i]["price"] = usd(user_data[i]["price"])

    return redirect("/")


@app.route("/history")
@login_required
def history():
    user_data = db.execute("SELECT *, (buyprice + sellprice) AS price FROM transactions WHERE userid = ?", session["user_id"])

    # Convert all numeric data into USD format
    for i in range(0, len(user_data), 1):
        user_data[i]["total"] = usd(user_data[i]["price"] * (user_data[i]["shares"]))
        user_data[i]["price"] = usd(user_data[i]["price"])

    return render_template("history.html", user_data=user_data)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    if request.method == "POST":

        # Reques symbols and check the symbol data
        symbol = request.form.get("symbol")
        quotes = lookup(symbol)

        # Check if the symbol input exist
        if symbol and quotes != None:
            name = quotes["name"]
            price = quotes["price"]
            symbol = quotes["symbol"]
            return render_template("quoted.html", name=name, price=usd(price), symbol=symbol)
        else:
            return apology("This stock doesn't exist", 400)

    else:
        return render_template("quote.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":

        password = request.form.get("password")
        confirmation = request.form.get("confirmation")
        username = request.form.get("username")

        TotalUsers = db.execute("SELECT username FROM users")

        # Check that the user fill all the blanks as requested
        if not username or not password or not confirmation:
            return apology("Please enter usarname, password and confirm password", 400)
        elif (password != confirmation):
            return apology("Password and Password Confirmation are different", 400)
        for i in range(0, len(TotalUsers), 1):
            if username == TotalUsers[i]["username"]:
                return apology("Please use another username", 400)

        hash = generate_password_hash(password, method='pbkdf2:sha256', salt_length=8)

        db.execute("INSERT INTO users (username, hash) VALUES(?, ?)", username, hash)

    else:
        return render_template("registration.html")

    """Register user"""
    return apology("User registered succesfully", 200)


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    if request.method == "POST":
        user_cash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
        user_data = db.execute(
            "SELECT symbol, SUM(shares) AS total_shares, type FROM transactions WHERE userid = ? GROUP BY symbol, type", session["user_id"])

        stock = request.form.get("symbol")
        sell_shares = request.form.get("shares")

        # Check that the user input valid data
        if not stock or not sell_shares:
            return apology("Please select one valid stock and number of shares", 400)

        sell_shares = int(sell_shares)
        stock_data = lookup(stock)
        price_stock = stock_data["price"]
        company = stock_data["name"]
        type = "SELL"

        total_shares = 0
        total_shares_sell = 0

        # Differentiation between buy and sell transactions
        for i in range(0, len(user_data), 1):
            symbol = user_data[i]["symbol"]
            if symbol == stock and user_data[i]["type"] == "BUY":
                total_shares_buy = user_data[i]["total_shares"]
            elif symbol == stock and user_data[i]["type"] == "SELL":
                total_shares_sell = user_data[i]["total_shares"]

        # Check for total transactions
        total_shares = total_shares_buy - total_shares_sell

        if total_shares == 0 or sell_shares <= 0:
            return apology("Please select one valid stock and number of shares", 400)

        buyprice = 0

        if total_shares >= sell_shares:
            cash = user_cash[0]["cash"] + (sell_shares * price_stock)
            db.execute("UPDATE users SET cash = ? WHERE id = ?", cash, session["user_id"])
            db.execute("INSERT INTO transactions (symbol, company, shares, sellprice, buyprice, userid, type) VALUES (?, ?, ?, ?, ?, ?, ?)",
                       stock, company, sell_shares, price_stock, buyprice, session["user_id"], type)
        else:
            return apology("Please select a valid amount of shares", 400)

    else:
        user_data = db.execute(
            "SELECT symbol, SUM(shares) AS total_shares FROM transactions WHERE userid = ? GROUP BY symbol", session["user_id"])

        stocks = []
        for i in range(0, len(user_data), 1):
            stocks.append(user_data[i]["symbol"])

        return render_template("sell.html", stocks=stocks)

    """Sell shares of stock"""
    return redirect("/")
