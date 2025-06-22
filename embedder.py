# embedder.py

import os
from langchain_community.document_loaders import TextLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain.embeddings import OllamaEmbeddings
from langchain.vectorstores import Chroma

DOCUMENTS_PATH = "documents/"
VECTOR_DB_PATH = "vector_store/"

def load_documents():
    documents = []
    for filename in os.listdir(DOCUMENTS_PATH):
        if filename.endswith(".txt"):
            loader = TextLoader(os.path.join(DOCUMENTS_PATH, filename))
            documents.extend(loader.load())
    return documents

def embed_documents():
    print("Loading documents...")
    docs = load_documents()

    print("Splitting documents into chunks...")
    splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
    chunks = splitter.split_documents(docs)

    print("Creating embeddings...")
    embeddings = OllamaEmbeddings(model="llama3")  # Change to the model you're running

    print("Storing in ChromaDB...")
    Chroma.from_documents(
        documents=chunks,
        embedding=embeddings,
        persist_directory=VECTOR_DB_PATH
    )

    print("✅ Embedding complete. Vector DB stored in:", VECTOR_DB_PATH)

if __name__ == "__main__":
    embed_documents()
