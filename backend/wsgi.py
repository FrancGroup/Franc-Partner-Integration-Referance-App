from app import app

if __name__ == "__main__":
    print("Running on port 5051")
    app.run(debug=False, port=5051)
