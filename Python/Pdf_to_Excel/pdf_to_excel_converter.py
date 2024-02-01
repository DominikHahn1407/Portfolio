import tabula
import pdfplumber
import pandas as pd

pdf_path = 'test.pdf'

def tabula():
    tables = tabula.read_pdf(pdf_path, pages='all', multiple_tables=True)
    combined_df = pd.concat(tables, ignore_index=True)
    excel_output_path = 'output.xlsx'
    combined_df.to_excel(excel_output_path, index=False)

def pdf_plumber():
    with pdfplumber.open(pdf_path) as pdf:
        # Initialize an empty string to store extracted text
        extracted_text = ''

        # Loop through all pages in the PDF
        for page_num in range(len(pdf.pages)):
            # Extract text from the page
            page = pdf.pages[page_num]
            text = page.extract_text()

            # Append the text to the string
            extracted_text += text

    # Print or use the extracted text as needed
    print(extracted_text)

pdf_plumber()
