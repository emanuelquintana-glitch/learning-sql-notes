"""
Tests básicos para Learning SQL Notes
"""

def test_addition():
    """Test básico de suma"""
    assert 1 + 1 == 2

def test_string():
    """Test básico de strings"""
    assert "hello".upper() == "HELLO"

def test_list():
    """Test básico de listas"""
    numbers = [1, 2, 3]
    assert len(numbers) == 3
    assert sum(numbers) == 6

if __name__ == "__main__":
    import pytest
    pytest.main([__file__, "-v"])
