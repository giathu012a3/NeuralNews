package neuralnews.model;

public class Category_Model {
    private int id;
    private String name;

    public Category_Model() {}

    public Category_Model(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
}