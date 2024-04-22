package hcmute.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import hcmute.entity.MilkTeaEntity;

@Repository
public interface MilkTeaRepository extends JpaRepository<MilkTeaEntity, Integer> {
	// find a product by id
	@Query("SELECT mt FROM MilkTeaEntity mt WHERE mt.milkTeaTypeByMilkTea.idType = :typeId")
	List<MilkTeaEntity> findAllByTypeId(int typeId);

	Optional<MilkTeaEntity> findByIdMilkTea(int id);

	@Query(value = "SELECT m.* FROM milk_tea m INNER JOIN "
			+ "(SELECT id_milk_tea FROM order_detail GROUP BY id_milk_tea ORDER BY SUM(quantity) DESC LIMIT 5) o "
			+ "ON m.id_milk_tea = o.id_milk_tea", nativeQuery = true)
	List<MilkTeaEntity> findFiveProductOutstanding();



	List<MilkTeaEntity> findAll();

	Page<MilkTeaEntity> findAll(Pageable pageable);

	// find relevant products
	// choose 4 products has the same type except the current product
	@Query("SELECT m FROM MilkTeaEntity m WHERE m.milkTeaTypeByMilkTea.idType = :typeId AND m.idMilkTea <> :milkTeaId")
	List<MilkTeaEntity> findRelevantProducts(@Param("typeId") int typeId, @Param("milkTeaId") int milkTeaId);

	long count();

	@Query(value = "SELECT * " + "FROM milk_tea " + "WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE Vietnamese_CI_AI) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE SQL_Latin1_General_CP1253_CI_AI)", nativeQuery = true)
	List<MilkTeaEntity> findByNameContaining(@Param("name") String name);

	@Query(value = "SELECT * " + "FROM milk_tea " + "WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE Vietnamese_CI_AI) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE SQL_Latin1_General_CP1253_CI_AI) "
			+ "ORDER BY cost ASC", nativeQuery = true)
	List<MilkTeaEntity> findByNameContainingAndSortAscendingByCost(@Param("name") String name);

	@Query(value = "SELECT * " + "FROM milk_tea " + "WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE Vietnamese_CI_AI) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE SQL_Latin1_General_CP1253_CI_AI) "
			+ "ORDER BY cost DESC", nativeQuery = true)
	List<MilkTeaEntity> findByNameContainingAndSortDescendingByCost(@Param("name") String name);

	@Query(value = "SELECT * FROM milk_tea WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8mb4_unicode_ci) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8mb4_general_ci)", nativeQuery = true)
	Page<MilkTeaEntity> findBynameContaining(@Param("name") String name, Pageable pageable);

	@Query(value = "SELECT * FROM milk_tea WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8_unicode_ci) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8_general_ci) "
			+ "ORDER BY cost ASC", nativeQuery = true)
	Page<MilkTeaEntity> findByNameContainingAndSortAscendingByCost(@Param("name") String name, Pageable pageable);

	@Query(value = "SELECT * FROM milk_tea WHERE "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8_unicode_ci) OR "
			+ "(LOWER(name) LIKE CONCAT('%', :name, '%') COLLATE utf8_general_ci) "
			+ "ORDER BY cost DESC", nativeQuery = true)
	Page<MilkTeaEntity> findByNameContainingAndSortDescendingByCost(@Param("name") String name, Pageable pageable);


	@Query("SELECT COUNT(mt) FROM MilkTeaEntity mt WHERE mt.milkTeaTypeByMilkTea.idType = :typeId")
	int countByTypeId(int typeId);

	@Query(value = "SELECT COUNT(*) FROM milk_tea WHERE LOWER(CAST(name AS CHAR CHARACTER SET latin1) COLLATE latin1_general_cs) LIKE LOWER(CONCAT('%', CAST(:name AS CHAR CHARACTER SET latin1) COLLATE latin1_general_cs, '%'))", nativeQuery = true)
	int countByNameContaining(@Param("name") String name);

	@Query("SELECT mt FROM MilkTeaEntity mt WHERE mt.milkTeaTypeByMilkTea.idType = :idType")
	Page<MilkTeaEntity> findAllByTypeId(int idType, Pageable pageable);
}
