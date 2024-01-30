import os

from flask import Flask, render_template
from flask_wtf import FlaskForm
from wtforms import FileField, SubmitField
import pandas as pd


app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret'


class UploadFileForm(FlaskForm):
    file = FileField("File")
    submit = SubmitField("Upload File")


@app.route('/', methods=['GET', 'POST'])
@app.route('/home', methods=['GET', 'POST'])
def home():
    html_table = ''
    form = UploadFileForm()
    if form.validate_on_submit():
        file = form.file.data
        df = pd.read_excel(file)
        html_table = df.to_html(index=False)
    return render_template("index.html", form=form, html_table=html_table)


if __name__ == '__main__':
    app.run(debug=True)
