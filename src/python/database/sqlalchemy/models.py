"""
Modelos SQLAlchemy para Learning SQL Notes
"""

from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, ForeignKey, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.sql import func
from datetime import datetime
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

# Base para modelos
Base = declarative_base()

class User(Base):
    """Modelo de usuario"""
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    full_name = Column(String(100))
    password_hash = Column(String(255))
    is_active = Column(Integer, default=1)
    created_at = Column(DateTime, default=func.ship("Exercise", back_populates="user")
    courses = relationship("UserCourse", back_populates="user")
    
    def __repr__(self):
        return f"<User(username={self.username}, email={self.email})>"

class Course(Base):
    """Modelo de curso"""
    __tablename__ = "courses"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(200), nullable=False)
    description = Column(Text)
    difficulty = Column(String(20), default="beginner")
    duration_hours = Column(Integer)
    created_at = Column(DateTime, default=func.now())
    
    # Relaciones
    exercises = relationship("Exercise", back_populates="course")
    user_courses = relationship("UserCourse", back_populates="course")
    
    def __repr__(self):
        return f"<Course(title={self.title}, difficulty={self.difficulty})>"

class Exercise(Base):
    """Modelo de ejercicio"""
    __tablename__ = "exercises"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    title = Column(String(200), nullable=False)
    description = Column(Text)
    solution = Column(Text)
    difficulty = Column(String(20), default="medium")
    created_at = Column(DateTime, default=func.now())
    
    # Relaciones
    course = relationship("Course", back_populates="exercises")
    user = relationship("User", back_populates="exercises")
    
    def __repr__(self):
        return f"<Exerciscursos"""
    __tablename__ = "user_courses"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    enrollment_date = Column(DateTime, default=func.now())
    completion_date = Column(DateTime)
    progress = Column(Float, default=0.0)
    
    # Relaciones
    user = relationship("User", back_populates="courses")
    course = relationship("Course", back_populates="user_courses")
    
    def __repr__(self):
        return f"<UserCourse(user_id={self.user_id}, course_id={self.course_id})>"

# Configuración de la base de datos
def get_database_url():
    """Obtener URL de base de datos desde variables de entorno"""
    db_type = os.getenv("DB_TYPE", "sqlite")
    
    if db_type == "mysql":
        return f"mysql+mysqlconnector://{os.getenv(MYSQL_USER)}:{os.getenv(MYSQL_PASSWORD)}@{os.getenv(MYSQL_HOST)}:{os.getenv(MYSQL_PORT)}/{os.getenv(MYSQL_DATABASE)}"
    elif db_type == "postgresql":
        return f"postgresql+psycopg2://{os.getenv(POSTGRES_USER)}:{os.getenv(POSTGRES_PASSWORD)}@{os.getenv(POSTGRES_HOST)}:{os.getenv(POSTGRES_PORT)}/{os.getenv(POSTGRES_DATABASE)}"
    else:
        # SQLite por defecto
        return "sqlite:///databases/sqlite/learning.db"

# Crear engine y sesión
engine = create_engine(get_database_url(), echo=False)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def init_database():
    """Inicializar la base de datos creando las tablas"""
    Base.metadata.create_all(bind=engine)
    print("✅ Base de datos inicializada")

def get_session():
    """Obtener sesión de base de datos"""
    session = SessionLocal()
    try:
        yield session
    finally:
        session.close()

if __name__ == "__main__":
    init_database()

