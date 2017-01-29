package dao;

import java.util.List;

import model.User;

/**
 * Contrato para el DAO de Usuario.
 * La password no es devuelta por el DAO por motivos de seguridad
 */
public interface UserDAO {

    public User find(Integer usuarioid) throws DAOException;

    public User find(String email, String password) throws DAOException;

    public List<User> list() throws DAOException;

    public void create(User user) throws IllegalArgumentException, DAOException;

    public void delete(User user) throws DAOException;

}